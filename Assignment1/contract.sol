// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// SimpleStorage: Stores and retrieves a single integer on the blockchain.
// Demonstrates state variables, setter, getter, and events.

contract SimpleStorage {

    // State variable to hold the stored number
    uint256 private storedData;

    // Owner of the contract
    address public owner;

    // Emitted whenever the stored value changes
    event DataStored(address indexed by, uint256 value);

    // Only owner can call restricted functions
    modifier onlyOwner() {
        require(msg.sender == owner, "Caller is not the owner");
        _;
    }

    // Sets deployer as owner; initializes storedData to 0
    constructor() {
        owner = msg.sender;
        storedData = 0;
    }

    // Store a new value (owner only)
    function set(uint256 x) public onlyOwner {
        storedData = x;
        emit DataStored(msg.sender, x);
    }

    // Retrieve the stored value (anyone)
    function get() public view returns (uint256) {
        return storedData;
    }
}
