
# Assignment 1: Smart Contract Development

## Contract Purpose

This assignment demonstrates writing a basic **SimpleStorage** smart contract in Solidity.
The contract allows the owner to store and retrieve a `uint256` value on the blockchain.


### Key Concepts Covered
- State variables
- Access modifiers (`onlyOwner`)
- Events (`ValueUpdated`)
- Getter and setter functions
- Constructor initialization

---


## Contract Functions

| Function | Visibility | Description |
|---|---|---|
| `constructor()` | internal | Sets deployer as owner, initializes `storedValue = 0` |
| `setValue(uint256)` | public (onlyOwner) | Updates the stored value and emits an event |
| `getValue()` | public view | Returns the current stored value |
| `getOwner()` | public view | Returns the owner's address |

---

## Compilation & Deployment Steps


### 1. Install Dependencies
```bash
npm init -y
npm install --save-dev hardhat
npx hardhat init
```


### 2. Copy Contract
Place `contract.sol` inside the `contracts/` folder of your Hardhat project.


### 3. Compile the Contract
```bash
npx hardhat compile
```
Expected output:
```
Compiled 1 Solidity file successfully
```


### 4. Deploy Locally
Run a local Hardhat node in one terminal:
```bash
npx hardhat node
```

Deploy in another terminal:
```bash
npx hardhat run scripts/deploy.js --network localhost
```

---


## Screenshots
> Add the following screenshots in this folder:
- `screenshot-compilation.png` – showing successful compilation output
- `screenshot-deployment.png` – showing contract deployment transaction

---


## Notes
- Solidity version used: `^0.8.0`
- Only the contract owner can update the value (access control via modifier)
- Events are emitted on every value update for transparency
