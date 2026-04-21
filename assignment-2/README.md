
# Assignment 2: Polygon Deployment


## Overview
This assignment deploys the `SimpleStorage` smart contract (updated version) onto the **Polygon Mumbai Testnet** using Hardhat.

---


## Contract Address
```
0xYourDeployedContractAddressHere
```
> ⚠️ Replace with your actual contract address after deployment.

---


## Network Details

| Detail | Value |
|---|---|
| Network Name | Polygon Mumbai Testnet |
| RPC URL | `https://rpc-mumbai.maticvigil.com` |
| Chain ID | `80001` |
| Currency Symbol | MATIC |
| Block Explorer | `https://mumbai.polygonscan.com` |

---


## Steps to Deploy on Polygon Testnet

### 1. Install Dependencies
```bash
npm install --save-dev hardhat @nomiclabs/hardhat-ethers ethers dotenv
```

### 2. Configure hardhat.config.js
```js
require("@nomiclabs/hardhat-ethers");
require("dotenv").config();

module.exports = {
  solidity: "0.8.0",
  networks: {
    polygonMumbai: {
      url: "https://rpc-mumbai.maticvigil.com",
      accounts: [process.env.PRIVATE_KEY],
    },
  },
};
```

### 3. Create `.env` File
```
PRIVATE_KEY=your_metamask_private_key_here
```

### 4. Get Test MATIC
Visit the Polygon faucet: https://faucet.polygon.technology/

### 5. Compile
```bash
npx hardhat compile
```

### 6. Deploy to Mumbai
```bash
npx hardhat run scripts/deploy.js --network polygonMumbai
```

---


## Screenshots
> Add the following screenshots in this folder:
- `screenshot-deployment-success.png` – Terminal showing deployment success + contract address
- `screenshot-explorer.png` – Transaction on Mumbai PolygonScan explorer

---


## Notes
- Always keep your `.env` file in `.gitignore` — never commit private keys
- Use Mumbai testnet MATIC (free from faucet), not real MATIC
