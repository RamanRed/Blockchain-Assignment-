
# Assignment 3: Web Interface + MetaMask


## Overview
A frontend DApp (Decentralized Application) that connects to the deployed `SimpleStorage` smart contract using **MetaMask** and **Ethers.js**.

---


## How the Frontend Connects to the Blockchain

1. The browser detects `window.ethereum` injected by the MetaMask extension.
2. `ethers.providers.Web3Provider` wraps the MetaMask provider to create a connection.
3. A `signer` is obtained (represents the connected wallet account).
4. A `Contract` instance is created using the deployed contract address + ABI.
5. Read calls use `.call()` (free, no gas), write calls create on-chain transactions.

---


## How MetaMask Is Used

| Action | MetaMask Role |
|---|---|
| Connect Wallet | Prompts user to allow site access to their account |
| Set Value | Prompts user to sign and pay for the transaction |
| Get Value | No MetaMask prompt (read-only call) |

---


## Files Included

| File | Purpose |
|---|---|
| `index.html` | Main DApp frontend (HTML + CSS + JS in one file) |

---


## How to Run

1. Make sure MetaMask is installed in your browser.
2. Open `index.html` directly in Chrome/Firefox.
3. Click **Connect MetaMask** — approve the connection.
4. Enter a number and click **Set Value** (MetaMask will ask to confirm tx).
5. Click **Get Value** to read the stored number.

> ⚠️ Update `CONTRACT_ADDRESS` in `index.html` with your deployed contract address from Assignment 2.

---


## Screenshots
> Add the following screenshots in this folder:
- `screenshot-wallet-connection.png` – MetaMask popup and connected account shown in UI
- `screenshot-transaction.png` – MetaMask transaction confirmation and success message

---


## Tech Used
- HTML / CSS / Vanilla JavaScript
- [Ethers.js v5](https://docs.ethers.org/v5/)
- MetaMask browser extension
