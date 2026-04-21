// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title SimpleStorage
 * @dev A basic smart contract to store and retrieve a value on the blockchain.
 *      Demonstrates state variables, getter/setter functions, and events.
 */
contract SimpleStorage {

    // State variable to store a number
    uint256 private storedValue;

    // Owner of the contract
    address public owner;

    // Event emitted when value is updated
    event ValueUpdated(address indexed updatedBy, uint256 newValue);

    // Modifier to restrict access to owner only
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    /**
     * @dev Constructor sets the deployer as the owner and initializes value to 0
     */
    constructor() {
        owner = msg.sender;
        storedValue = 0;
    }

    /**
     * @dev Store a new value (only owner)
     * @param _value The new value to store
     */
    function setValue(uint256 _value) public onlyOwner {
        storedValue = _value;
        emit ValueUpdated(msg.sender, _value);
    }

    /**
     * @dev Retrieve the stored value
     * @return The current stored value
     */
    function getValue() public view returns (uint256) {
        return storedValue;
    }

    /**
     * @dev Get the contract owner address
     * @return Owner's address
     */
    function getOwner() public view returns (address) {
        return owner;
    }
}
