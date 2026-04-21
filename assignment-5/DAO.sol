// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title SimpleDAO
 * @dev A Decentralized Autonomous Organization (DAO) smart contract.
 *      Members can create proposals, vote on them, and execute approved ones.
 *
 * Workflow:
 *  1. Owner deploys the contract and can add members.
 *  2. Any member can create a proposal.
 *  3. Members vote FOR or AGAINST within the voting period.
 *  4. After voting ends, the proposal can be executed if votes FOR > votes AGAINST.
 */
contract SimpleDAO {

    // ── STRUCTS ──────────────────────────────────────────────────────────────

    struct Proposal {
        uint256 id;                  // Unique proposal ID
        string description;          // What is being proposed
        address proposer;            // Who created the proposal
        uint256 votesFor;            // Total votes in favour
        uint256 votesAgainst;        // Total votes against
        uint256 deadline;            // Voting deadline (block timestamp)
        bool executed;               // Whether the proposal was executed
        bool passed;                 // Whether the proposal passed
    }

    // ── STATE VARIABLES ──────────────────────────────────────────────────────

    address public owner;
    uint256 public proposalCount;
    uint256 public votingDuration = 3 minutes; // Adjustable voting window

    mapping(uint256 => Proposal) public proposals;
    mapping(address => bool) public members;
    // proposalId => voter => hasVoted
    mapping(uint256 => mapping(address => bool)) public hasVoted;

    // ── EVENTS ───────────────────────────────────────────────────────────────

    event MemberAdded(address indexed member);
    event MemberRemoved(address indexed member);
    event ProposalCreated(uint256 indexed id, string description, address proposer, uint256 deadline);
    event VoteCast(uint256 indexed proposalId, address indexed voter, bool support);
    event ProposalExecuted(uint256 indexed id, bool passed);

    // ── MODIFIERS ────────────────────────────────────────────────────────────

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this");
        _;
    }

    modifier onlyMember() {
        require(members[msg.sender], "Only DAO members can call this");
        _;
    }

    modifier proposalExists(uint256 _id) {
        require(_id > 0 && _id <= proposalCount, "Proposal does not exist");
        _;
    }

    // ── CONSTRUCTOR ──────────────────────────────────────────────────────────

    /**
     * @dev Deploys the DAO. The deployer is set as owner and first member.
     */
    constructor() {
        owner = msg.sender;
        members[msg.sender] = true;
        emit MemberAdded(msg.sender);
    }

    // ── MEMBER MANAGEMENT ────────────────────────────────────────────────────

    /**
     * @dev Add a new DAO member (owner only)
     * @param _member Address to add as member
     */
    function addMember(address _member) public onlyOwner {
        require(!members[_member], "Already a member");
        members[_member] = true;
        emit MemberAdded(_member);
    }

    /**
     * @dev Remove a DAO member (owner only)
     * @param _member Address to remove
     */
    function removeMember(address _member) public onlyOwner {
        require(_member != owner, "Cannot remove owner");
        require(members[_member], "Not a member");
        members[_member] = false;
        emit MemberRemoved(_member);
    }

    // ── PROPOSAL MANAGEMENT ──────────────────────────────────────────────────

    /**
     * @dev Create a new proposal
     * @param _description Text description of what is being proposed
     * @return newId The ID of the newly created proposal
     */
    function createProposal(string memory _description) public onlyMember returns (uint256 newId) {
        require(bytes(_description).length > 0, "Description cannot be empty");

        proposalCount++;
        newId = proposalCount;

        proposals[newId] = Proposal({
            id: newId,
            description: _description,
            proposer: msg.sender,
            votesFor: 0,
            votesAgainst: 0,
            deadline: block.timestamp + votingDuration,
            executed: false,
            passed: false
        });

        emit ProposalCreated(newId, _description, msg.sender, proposals[newId].deadline);
    }

    // ── VOTING ───────────────────────────────────────────────────────────────

    /**
     * @dev Cast a vote on an active proposal
     * @param _proposalId ID of the proposal to vote on
     * @param _support true = vote FOR, false = vote AGAINST
     */
    function castVote(uint256 _proposalId, bool _support)
        public
        onlyMember
        proposalExists(_proposalId)
    {
        Proposal storage proposal = proposals[_proposalId];

        require(block.timestamp < proposal.deadline, "Voting period has ended");
        require(!hasVoted[_proposalId][msg.sender], "You have already voted");
        require(!proposal.executed, "Proposal already executed");

        hasVoted[_proposalId][msg.sender] = true;

        if (_support) {
            proposal.votesFor++;
        } else {
            proposal.votesAgainst++;
        }

        emit VoteCast(_proposalId, msg.sender, _support);
    }

    // ── EXECUTION ────────────────────────────────────────────────────────────

    /**
     * @dev Execute a proposal after voting ends.
     *      Passes if votesFor > votesAgainst.
     * @param _proposalId ID of the proposal to execute
     */
    function executeProposal(uint256 _proposalId)
        public
        onlyMember
        proposalExists(_proposalId)
    {
        Proposal storage proposal = proposals[_proposalId];

        require(block.timestamp >= proposal.deadline, "Voting period not yet ended");
        require(!proposal.executed, "Proposal already executed");

        proposal.executed = true;
        proposal.passed = proposal.votesFor > proposal.votesAgainst;

        emit ProposalExecuted(_proposalId, proposal.passed);
    }

    // ── GETTERS ──────────────────────────────────────────────────────────────

    /**
     * @dev Get full details of a proposal
     */
    function getProposal(uint256 _proposalId)
        public
        view
        proposalExists(_proposalId)
        returns (
            uint256 id,
            string memory description,
            address proposer,
            uint256 votesFor,
            uint256 votesAgainst,
            uint256 deadline,
            bool executed,
            bool passed
        )
    {
        Proposal storage p = proposals[_proposalId];
        return (
            p.id,
            p.description,
            p.proposer,
            p.votesFor,
            p.votesAgainst,
            p.deadline,
            p.executed,
            p.passed
        );
    }

    /**
     * @dev Check if an address is a DAO member
     */
    function isMember(address _addr) public view returns (bool) {
        return members[_addr];
    }

    /**
     * @dev Check if an address has voted on a proposal
     */
    function didVote(uint256 _proposalId, address _voter) public view returns (bool) {
        return hasVoted[_proposalId][_voter];
    }
}
