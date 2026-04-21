# Assignment 3: Web Interface + MetaMask

## 📋 Overview

A frontend **Decentralized Application (DApp)** built with plain HTML, CSS, and JavaScript that connects to the deployed `SimpleStorage` smart contract via **MetaMask** and **Ethers.js v5**.

---

## 🔗 How Frontend Connects to the Blockchain

1. **MetaMask** injects `window.ethereum` into the browser automatically when the extension is installed.
2. Clicking **Connect MetaMask** calls `eth_requestAccounts` — the user approves in MetaMask.
3. `ethers.providers.Web3Provider(window.ethereum)` wraps the MetaMask provider.
4. A `signer` is obtained — this represents the connected user account.
5. A `Contract` object is created using the deployed **contract address** + **ABI**.
6. All reads (`get()`) are free — no MetaMask prompt.
7. All writes (`set()`, `reset()`) trigger a MetaMask transaction popup asking the user to pay gas.

---

## 🦊 How MetaMask Is Used

| Action | What Happens in MetaMask |
|---|---|
| Connect Wallet | Popup to approve site access |
| Set Value | Popup to confirm transaction + pay gas |
| Reset Value | Popup to confirm transaction + pay gas |
| Get Value | No popup (read-only, no gas needed) |

---

## 📁 Files

| File | Description |
|---|---|
| `index.html` | Complete DApp (HTML + CSS + JS in one file) |

---

## 🚀 How to Run

### Option A — Python Server (Recommended)
```bash
cd Assignment3
python -m http.server 3000
```
Open: http://127.0.0.1:3000

### Option B — VS Code Live Server
Right-click `index.html` → **Open with Live Server**

### Option C — Direct Open
Double-click `index.html` to open in browser.
> ⚠️ MetaMask may block direct file:// URLs — use Option A or B if connection fails.

---

## ⚙️ Setup Before Running

1. Open `index.html` in a text editor.
2. Find this line:
   ```js
   const CONTRACT_ADDRESS = "0xYourDeployedContractAddressHere";
   ```
3. Replace it with your actual deployed contract address from **Assignment 2**.
4. Save and reload.

---

## 📸 Screenshots
> Add the following screenshots to this folder:
- `screenshot-wallet-connection.png` — MetaMask popup + connected account shown in UI
- `screenshot-set-transaction.png` — MetaMask transaction confirmation while calling `set()`
- `screenshot-get-value.png` — UI displaying the stored value after calling `get()`

---

## 🛠️ Tech Used
- HTML5 / CSS3 / Vanilla JavaScript
- [Ethers.js v5](https://docs.ethers.org/v5/) (loaded via CDN)
- MetaMask browser extension
