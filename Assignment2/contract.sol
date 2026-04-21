// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// SimpleStorage — deployed on Polygon Amoy Testnet.
// Updated version: adds a reset function and records last update timestamp.

contract SimpleStorage {

    uint256 private storedData;
    address public owner;
    uint256 public lastUpdatedAt;

    event DataStored(address indexed by, uint256 value, uint256 timestamp);
    event DataReset(address indexed by, uint256 timestamp);

    modifier onlyOwner() {
        require(msg.sender == owner, "Caller is not the owner");
        _;
    }

    constructor() {
        owner = msg.sender;
        storedData = 0;
        lastUpdatedAt = block.timestamp;
    }

    // Store a new value
    function set(uint256 x) public onlyOwner {
        storedData = x;
        lastUpdatedAt = block.timestamp;
        emit DataStored(msg.sender, x, block.timestamp);
    }

    // Reset stored value to 0
    function reset() public onlyOwner {
        storedData = 0;
        lastUpdatedAt = block.timestamp;
        emit DataReset(msg.sender, block.timestamp);
    }

    // Retrieve current value
    function get() public view returns (uint256) {
        return storedData;
    }
}
