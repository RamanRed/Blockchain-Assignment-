// IPFS Upload & Retrieval using Pinata API
// Assignment 4 – Blockchain Technology
// Run: node upload.js

const fs = require("fs");
const path = require("path");
const FormData = require("form-data");
const axios = require("axios");
require("dotenv").config();

// ── CONFIG ──────────────────────────────────────────────────────────────────
const PINATA_API_KEY = process.env.PINATA_API_KEY;
const PINATA_SECRET_KEY = process.env.PINATA_SECRET_KEY;
const FILE_TO_UPLOAD = "./sample.txt"; // Change this to your file
// ────────────────────────────────────────────────────────────────────────────

/**
 * Upload a file to IPFS via Pinata
 * @param {string} filePath - Local path of file to upload
 * @returns {string} IPFS CID (Content Identifier)
 */
async function uploadToIPFS(filePath) {
  const formData = new FormData();
  const fileStream = fs.createReadStream(filePath);
  const fileName = path.basename(filePath);

  formData.append("file", fileStream, { filename: fileName });

  const metadata = JSON.stringify({ name: fileName });
  formData.append("pinataMetadata", metadata);

  const options = JSON.stringify({ cidVersion: 1 });
  formData.append("pinataOptions", options);

  try {
    console.log(`\n📤 Uploading "${fileName}" to IPFS via Pinata...`);

    const response = await axios.post(
      "https://api.pinata.cloud/pinning/pinFileToIPFS",
      formData,
      {
        maxBodyLength: Infinity,
        headers: {
          ...formData.getHeaders(),
          pinata_api_key: PINATA_API_KEY,
          pinata_secret_api_key: PINATA_SECRET_KEY,
        },
      }
    );

    const cid = response.data.IpfsHash;
    console.log(`\n✅ Upload Successful!`);
    console.log(`📌 CID (Content ID): ${cid}`);
    console.log(`🔗 View on IPFS Gateway: https://gateway.pinata.cloud/ipfs/${cid}`);
    console.log(`🌐 Public IPFS Link:     https://ipfs.io/ipfs/${cid}`);

    return cid;
  } catch (err) {
    console.error("❌ Upload failed:", err.response?.data || err.message);
    throw err;
  }
}

/**
 * Retrieve file info from IPFS by CID
 * @param {string} cid - IPFS Content Identifier
 */
async function retrieveFromIPFS(cid) {
  const gatewayUrl = `https://gateway.pinata.cloud/ipfs/${cid}`;
  console.log(`\n📥 Retrieving file from IPFS...`);
  console.log(`🔗 URL: ${gatewayUrl}`);

  try {
    const response = await axios.get(gatewayUrl, { responseType: "text" });
    console.log(`\n📄 File Content:\n${response.data}`);
  } catch (err) {
    console.error("❌ Retrieval failed:", err.message);
  }
}

// ── MAIN ────────────────────────────────────────────────────────────────────
(async () => {
  if (!PINATA_API_KEY || !PINATA_SECRET_KEY) {
    console.error("❌ Missing Pinata API keys in .env file!");
    process.exit(1);
  }

  // 1. Upload file
  const cid = await uploadToIPFS(FILE_TO_UPLOAD);

  // 2. Retrieve it back
  await retrieveFromIPFS(cid);
})();
