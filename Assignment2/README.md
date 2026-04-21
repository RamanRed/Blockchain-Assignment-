# Assignment 2: Polygon Amoy Deployment

## 📋 Overview

This assignment deploys the `SimpleStorage` smart contract (updated version) on the **Polygon Amoy Testnet** using Remix IDE and MetaMask.

Polygon offers faster transactions and much lower gas fees compared to Ethereum mainnet, making it ideal for deploying and testing DApps.

---

## 🌐 Network Details

| Parameter | Value |
|---|---|
| Network Name | Polygon Amoy Testnet |
| RPC URL | `https://rpc-amoy.polygon.technology` |
| Chain ID | `80002` |
| Currency Symbol | MATIC |
| Block Explorer | https://amoy.polygonscan.com |

> Add these details to MetaMask manually under **Settings → Networks → Add Network**.

---

## 📄 Contract Address

```
0xYourDeployedContractAddressHere
```
> ⚠️ Replace with the actual contract address shown in Remix after deployment.

---

## 🚀 Steps to Deploy on Polygon Amoy

### Step 1 — Add Polygon Amoy to MetaMask
- Open MetaMask → **Add Network → Add Network Manually**
- Enter the network details from the table above
- Save and switch to **Polygon Amoy**

### Step 2 — Get Test MATIC
- Visit the Polygon faucet: https://faucet.polygon.technology
- Select **Amoy** and paste your wallet address
- Receive free test MATIC

### Step 3 — Open Remix IDE
- Go to: https://remix.ethereum.org
- Create `contract.sol` and paste the contract code

### Step 4 — Compile
- Go to **Solidity Compiler** tab
- Select version `^0.8.0`
- Click **Compile contract.sol**

### Step 5 — Deploy
- Go to **Deploy & Run Transactions**
- Set **Environment** → `Injected Provider - MetaMask`
- MetaMask should show **Polygon Amoy** network
- Click **Deploy** → confirm in MetaMask

### Step 6 — Verify on Explorer
- Copy the deployed contract address from Remix
- Paste it at: https://amoy.polygonscan.com
- View the deployment transaction

---

## 📸 Screenshots
> Add the following screenshots to this folder:
- `screenshot-deployment-success.png` — Remix terminal showing deployed contract address
- `screenshot-explorer.png` — Transaction page on Amoy PolygonScan

---

## 💡 Why Polygon?
- Gas fees ~100x cheaper than Ethereum
- Fully EVM-compatible (same Solidity code works)
- Fast block finality (~2 seconds)
