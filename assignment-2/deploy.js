// Hardhat Deployment Script for Polygon Mumbai Testnet
// File: scripts/deploy.js

const hre = require("hardhat");

async function main() {
  console.log("Deploying SimpleStorage to Polygon Mumbai...");

  // Get the contract factory
  const SimpleStorage = await hre.ethers.getContractFactory("SimpleStorage");

  // Deploy the contract
  const simpleStorage = await SimpleStorage.deploy();

  // Wait for deployment to complete
  await simpleStorage.deployed();

  console.log(`SimpleStorage deployed to: ${simpleStorage.address}`);
  console.log(`Transaction hash: ${simpleStorage.deployTransaction.hash}`);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
