# Assignment 5: DAO Smart Contract

## 📋 Overview

A basic **Decentralized Autonomous Organization (DAO)** implemented in Solidity. Members can create proposals, vote on them within a time-limited window, and execute decisions on-chain based on the vote outcome.

Reference: [DAOs – A Step-by-Step Guide](https://medium.com/@cromewar/decentralized-autonomous-organizations-a-step-by-step-guide-468c11179ced)

---

## 🔄 DAO Workflow

```
1. Owner deploys dao.sol
         │
         ▼
2. Owner adds members  →  addMember(address)
         │
         ▼
3. Member creates proposal  →  createProposal("description")
         │
         ▼
4. Voting window opens (5 minutes)
   Members call  →  vote(proposalId, true/false)
         │
         ▼
5. Voting window closes (deadline reached)
         │
         ▼
6. Anyone calls  →  executeProposal(proposalId)
         │
   votesFor > votesAgainst  →  ✅ PASSED
   votesFor ≤ votesAgainst  →  ❌ FAILED
```

---

## ⚙️ Voting Mechanism

- Each DAO member gets **exactly one vote** per proposal (enforced by `hasVoted` mapping).
- Voting is open until `block.timestamp >= proposal.deadline`.
- Default voting window: **5 minutes** (adjustable via `votingPeriod` state variable).
- A proposal **passes** when `votesFor > votesAgainst`.
- Once executed, a proposal **cannot be executed again**.
- Only current DAO members can vote and create proposals.

---

## 📄 Proposal Creation

Any member can call:
```solidity
createProposal("Increase developer fund by 10%")
```
This stores the proposal on-chain with:
- A unique ID
- Description text
- Proposer address
- Voting deadline (current time + votingPeriod)
- Vote counters initialized to 0

---

## 🗳️ Contract Functions

### Member Management
| Function | Access | Description |
|---|---|---|
| `addMember(address)` | Owner | Add a wallet as a DAO member |
| `removeMember(address)` | Owner | Remove a member (owner cannot be removed) |
| `isMember(address)` | Public view | Check if an address is a member |

### Proposals
| Function | Access | Description |
|---|---|---|
| `createProposal(string)` | Members | Create a new proposal |
| `getProposal(uint256)` | Public view | Get full details of one proposal |
| `getProposals()` | Public view | Get all proposals as an array |

### Voting
| Function | Access | Description |
|---|---|---|
| `vote(uint256, bool)` | Members | Vote FOR (`true`) or AGAINST (`false`) |
| `didVote(uint256, address)` | Public view | Check if an address has already voted |

### Execution
| Function | Access | Description |
|---|---|---|
| `executeProposal(uint256)` | Members | Execute proposal after voting ends |

---

## 🚀 Compilation & Deployment (Remix IDE)

### Step 1 — Open Remix
Go to: https://remix.ethereum.org

### Step 2 — Create File
- Create `dao.sol` and paste the contract code

### Step 3 — Compile
- Go to **Solidity Compiler** tab
- Select version `^0.8.0`
- Click **Compile dao.sol**
- ✅ Green checkmark = success

### Step 4 — Deploy
- Go to **Deploy & Run Transactions**
- Set Environment → `Injected Provider - MetaMask`
- Switch MetaMask to **Sepolia** or **Polygon Amoy**
- Click **Deploy** → confirm in MetaMask

### Step 5 — Interact in Remix

**Add members:**
```
addMember → 0xOtherWalletAddress
```

**Create a proposal:**
```
createProposal → "Fund new marketing campaign"
```

**Vote (from member accounts):**
```
vote → (1, true)   // proposalId=1, support=true (FOR)
vote → (1, false)  // proposalId=1, support=false (AGAINST)
```

**Execute after voting period:**
```
executeProposal → 1
```

**View all proposals:**
```
getProposals()
```

---

## 📸 Screenshots
> Add the following screenshots to this folder:
- `screenshot-proposal-creation.png` — Remix showing `createProposal` call and transaction
- `screenshot-voting.png` — `vote()` being called from different accounts
- `screenshot-execution.png` — `executeProposal()` result showing passed/failed status

---

## 🧠 Key Solidity Concepts Used

| Concept | Where Used |
|---|---|
| `struct` | `Proposal` — groups all proposal data together |
| Nested `mapping` | `hasVoted[proposalId][voterAddress]` — prevents double voting |
| `modifier` | `onlyOwner`, `onlyMember`, `validProposal` — access control |
| `event` | Emitted on every state change for transparency |
| `block.timestamp` | Sets and checks the voting deadline |
| `calldata` | Gas-efficient string input for `createProposal` |
| Dynamic array | `getProposals()` returns all proposals at once |
