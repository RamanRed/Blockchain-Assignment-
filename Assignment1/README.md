# Assignment 1: Smart Contract Development

## 📋 Contract Purpose

`SimpleStorage` is a basic Solidity smart contract that stores and retrieves a single integer value on the Ethereum blockchain (Sepolia Testnet).

It demonstrates foundational Solidity concepts:
- State variables
- Constructor
- Access control with `modifier`
- Events
- Getter and setter functions

---

## ⚙️ Functions & Logic

| Function | Visibility | Description |
|---|---|---|
| `constructor()` | — | Sets deployer as `owner`, initializes `storedData = 0` |
| `set(uint256 x)` | public (onlyOwner) | Stores a new value; emits `DataStored` event |
| `get()` | public view | Returns the current stored value |

### Access Control
Only the contract owner (deployer) can call `set()`. Anyone can call `get()` for free.

### Event
```solidity
event DataStored(address indexed by, uint256 value);
```
Emitted every time a new value is stored, logging who set it and what value.

---

## 🚀 Compilation & Deployment Steps

### Step 1 — Open Remix IDE
Go to: https://remix.ethereum.org

### Step 2 — Create File
- In the File Explorer, create a new file: `contract.sol`
- Paste the contents of `contract.sol`

### Step 3 — Compile
- Click the **Solidity Compiler** tab (left sidebar)
- Select compiler version `0.8.0` or higher
- Click **Compile contract.sol**
- ✅ You should see a green checkmark

### Step 4 — Connect MetaMask to Sepolia
- Open MetaMask → switch network to **Sepolia Testnet**
- Get test ETH from: https://sepoliafaucet.com

### Step 5 — Deploy
- Click the **Deploy & Run Transactions** tab
- Set **Environment** → `Injected Provider - MetaMask`
- MetaMask will connect automatically
- Click **Deploy** → confirm in MetaMask

### Step 6 — Interact
- After deployment, expand the contract under **Deployed Contracts**
- Call `set(42)` → confirm transaction in MetaMask
- Call `get()` → returns `42`

---

## 📸 Screenshots
> Add the following screenshots to this folder:
- `screenshot-compilation.png` — Remix showing successful compilation
- `screenshot-deployment.png` — Deployed contract on Sepolia (Remix + MetaMask popup)

---

## 🌐 Network Used
- **Sepolia Testnet** (Ethereum)
- Chain ID: `11155111`
- Explorer: https://sepolia.etherscan.io
