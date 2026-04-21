# Assignment 5: DAO Smart Contract

## Overview
A **Decentralized Autonomous Organization (DAO)** smart contract written in Solidity.  
Members can create proposals, vote on them within a time window, and execute the result on-chain.

Reference: [DAOs – Step by Step Guide](https://medium.com/@cromewar/decentralized-autonomous-organizations-a-step-by-step-guide-468c11179ced)

---

## DAO Workflow

```
Owner deploys contract
       │
       ▼
  Add Members (addMember)
       │
       ▼
  Member creates Proposal (createProposal)
       │
       ▼
  Voting window opens (3 minutes by default)
       │
  Members cast votes → castVote(id, true/false)
       │
       ▼
  Voting window closes
       │
       ▼
  Anyone calls executeProposal(id)
       │
  votesFor > votesAgainst → Proposal PASSED ✅
  votesFor ≤ votesAgainst → Proposal FAILED ❌
```

---

## Contract Functions

### Member Management
| Function | Access | Description |
|---|---|---|
| `addMember(address)` | Owner only | Add a wallet as a DAO member |
| `removeMember(address)` | Owner only | Remove a member (owner cannot be removed) |
| `isMember(address)` | Public view | Check if an address is a member |

### Proposal Creation
| Function | Access | Description |
|---|---|---|
| `createProposal(string)` | Members only | Create a new proposal with a description |

### Voting
| Function | Access | Description |
|---|---|---|
| `castVote(uint256, bool)` | Members only | Vote FOR (`true`) or AGAINST (`false`) a proposal |
| `didVote(uint256, address)` | Public view | Check if an address already voted on a proposal |

### Execution
| Function | Access | Description |
|---|---|---|
| `executeProposal(uint256)` | Members only | Execute a proposal after voting deadline passes |
| `getProposal(uint256)` | Public view | Fetch full details of a proposal |

---

## Voting Mechanism

- Each member gets **one vote** per proposal (enforced via `hasVoted` mapping)
- Voting is open until `block.timestamp >= proposal.deadline`
- Default voting duration is **3 minutes** (adjustable in contract)
- A proposal **passes** if `votesFor > votesAgainst`
- Once executed, a proposal cannot be re-executed

---

## Compilation & Deployment

### 1. Install Hardhat
```bash
npm init -y
npm install --save-dev hardhat @nomiclabs/hardhat-ethers ethers
npx hardhat init
```

### 2. Place Contract
Copy `DAO.sol` into the `contracts/` folder.

### 3. Compile
```bash
npx hardhat compile
```


### 4. Deploy Locally
```bash
npx hardhat node
npx hardhat run scripts/deploy.js --network localhost
```

---

## Screenshots
> Add the following screenshots in this folder:
- `screenshot-compilation.png` – showing successful compilation output
- `screenshot-deployment.png` – showing contract deployment transaction
- `screenshot-voting.png` – showing voting and execution events

---

## Notes
- Only the owner can add/remove members
- Only members can create proposals and vote
- Voting is time-limited (default: 3 minutes)
- Once executed, proposals cannot be re-executed
- Always keep your `.env` file in `.gitignore` — never commit private keys
```js
const hre = require("hardhat");
async function main() {
  const DAO = await hre.ethers.getContractFactory("SimpleDAO");
  const dao = await DAO.deploy();
  await dao.deployed();
  console.log("DAO deployed to:", dao.address);
}
main().then(() => process.exit(0)).catch(console.error);
```

---

## Screenshots
> Add the following screenshots in this folder:
- `screenshot-proposal-creation.png` – Creating a proposal (Remix or script output)
- `screenshot-voting.png` – Casting votes from multiple accounts
- `screenshot-execution.png` – Executing the proposal and viewing passed/failed result

---

## Key Solidity Concepts Used
- `struct` for Proposal data
- Nested `mapping` for vote tracking
- `modifier` for access control (onlyOwner, onlyMember)
- `event` emission for transparency
- `block.timestamp` for time-based voting deadline
