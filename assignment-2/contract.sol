// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title SimpleStorage
 * @dev Updated version deployed on Polygon Mumbai Testnet.
 *      Includes additional reset function and public timestamp tracking.
 */
contract SimpleStorage {

    uint256 private storedValue;
    address public owner;
    uint256 public lastUpdated;

    event ValueUpdated(address indexed updatedBy, uint256 newValue, uint256 timestamp);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    constructor() {
        owner = msg.sender;
        storedValue = 0;
        lastUpdated = block.timestamp;
    }

    /**
     * @dev Store a new value
     */
    function setValue(uint256 _value) public onlyOwner {
        storedValue = _value;
        lastUpdated = block.timestamp;
        emit ValueUpdated(msg.sender, _value, block.timestamp);
    }

    /**
     * @dev Reset value to 0
     */
    function resetValue() public onlyOwner {
        storedValue = 0;
        lastUpdated = block.timestamp;
        emit ValueUpdated(msg.sender, 0, block.timestamp);
    }

    /**
     * @dev Get stored value
     */
    function getValue() public view returns (uint256) {
        return storedValue;
    }

    /**
     * @dev Get owner address
     */
    function getOwner() public view returns (address) {
        return owner;
    }
}
