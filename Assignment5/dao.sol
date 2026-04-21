// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title SimpleDAO
 * @dev A Decentralized Autonomous Organization (DAO) contract.
 *
 * Workflow:
 *  1. Owner deploys and is automatically the first member.
 *  2. Owner adds members via addMember().
 *  3. Any member calls createProposal() with a description.
 *  4. Members call vote() with the proposal ID and their choice (true = for, false = against).
 *  5. After the voting period ends, any member calls executeProposal().
 *  6. Proposal passes if votesFor > votesAgainst.
 */
contract SimpleDAO {

    // ─── STRUCTS ──────────────────────────────────────────────────────────────

    struct Proposal {
        uint256 id;
        string  description;
        address proposer;
        uint256 votesFor;
        uint256 votesAgainst;
        uint256 deadline;
        bool    executed;
        bool    passed;
    }

    // ─── STATE VARIABLES ──────────────────────────────────────────────────────

    address public owner;
    uint256 public proposalCount;
    uint256 public votingPeriod = 5 minutes;

    mapping(uint256 => Proposal) public proposals;
    mapping(address => bool)     public members;
    mapping(uint256 => mapping(address => bool)) public hasVoted;

    // ─── EVENTS ───────────────────────────────────────────────────────────────

    event MemberAdded(address indexed member);
    event MemberRemoved(address indexed member);
    event ProposalCreated(uint256 indexed id, string description, address proposer, uint256 deadline);
    event Voted(uint256 indexed proposalId, address indexed voter, bool support);
    event ProposalExecuted(uint256 indexed id, bool passed);

    // ─── MODIFIERS ────────────────────────────────────────────────────────────

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner");
        _;
    }

    modifier onlyMember() {
        require(members[msg.sender], "Only DAO members");
        _;
    }

    modifier validProposal(uint256 _id) {
        require(_id > 0 && _id <= proposalCount, "Invalid proposal ID");
        _;
    }

    // ─── CONSTRUCTOR ──────────────────────────────────────────────────────────

    constructor() {
        owner = msg.sender;
        members[msg.sender] = true;
        emit MemberAdded(msg.sender);
    }

    // ─── MEMBER MANAGEMENT ────────────────────────────────────────────────────

    /// @dev Add a new DAO member (owner only)
    function addMember(address _member) external onlyOwner {
        require(!members[_member], "Already a member");
        members[_member] = true;
        emit MemberAdded(_member);
    }

    /// @dev Remove a member (cannot remove owner)
    function removeMember(address _member) external onlyOwner {
        require(_member != owner, "Cannot remove owner");
        require(members[_member], "Not a member");
        members[_member] = false;
        emit MemberRemoved(_member);
    }

    // ─── PROPOSALS ────────────────────────────────────────────────────────────

    /// @dev Create a new proposal; any member can call this
    function createProposal(string calldata _description)
        external
        onlyMember
        returns (uint256 id)
    {
        require(bytes(_description).length > 0, "Empty description");

        proposalCount++;
        id = proposalCount;

        proposals[id] = Proposal({
            id:           id,
            description:  _description,
            proposer:     msg.sender,
            votesFor:     0,
            votesAgainst: 0,
            deadline:     block.timestamp + votingPeriod,
            executed:     false,
            passed:       false
        });

        emit ProposalCreated(id, _description, msg.sender, proposals[id].deadline);
    }

    // ─── VOTING ───────────────────────────────────────────────────────────────

    /// @dev Cast a vote on an open proposal
    /// @param _id     The proposal ID
    /// @param _support true = FOR, false = AGAINST
    function vote(uint256 _id, bool _support)
        external
        onlyMember
        validProposal(_id)
    {
        Proposal storage p = proposals[_id];
        require(block.timestamp < p.deadline,       "Voting period ended");
        require(!hasVoted[_id][msg.sender],          "Already voted");
        require(!p.executed,                         "Already executed");

        hasVoted[_id][msg.sender] = true;

        if (_support) {
            p.votesFor++;
        } else {
            p.votesAgainst++;
        }

        emit Voted(_id, msg.sender, _support);
    }

    // ─── EXECUTION ────────────────────────────────────────────────────────────

    /// @dev Execute a proposal after its voting period has ended
    function executeProposal(uint256 _id)
        external
        onlyMember
        validProposal(_id)
    {
        Proposal storage p = proposals[_id];
        require(block.timestamp >= p.deadline, "Voting still open");
        require(!p.executed,                   "Already executed");

        p.executed = true;
        p.passed   = p.votesFor > p.votesAgainst;

        emit ProposalExecuted(_id, p.passed);
    }

    // ─── GETTERS ──────────────────────────────────────────────────────────────

    /// @dev Returns all details of a proposal
    function getProposal(uint256 _id)
        external
        view
        validProposal(_id)
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
        Proposal storage p = proposals[_id];
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

    /// @dev Returns all proposals as an array
    function getProposals() external view returns (Proposal[] memory) {
        Proposal[] memory all = new Proposal[](proposalCount);
        for (uint256 i = 1; i <= proposalCount; i++) {
            all[i - 1] = proposals[i];
        }
        return all;
    }

    /// @dev Check if address is a member
    function isMember(address _addr) external view returns (bool) {
        return members[_addr];
    }

    /// @dev Check if an address has voted on a proposal
    function didVote(uint256 _id, address _voter) external view returns (bool) {
        return hasVoted[_id][_voter];
    }
}
