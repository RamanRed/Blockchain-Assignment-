
# Assignment 4: IPFS Integration


## Overview
This assignment demonstrates uploading and retrieving files from **IPFS** (InterPlanetary File System) using the **Pinata** pinning service and its REST API.

---


## IPFS Service & Library Used

| Tool | Purpose |
|---|---|
| [Pinata](https://pinata.cloud) | IPFS pinning service (free tier available) |
| `axios` | HTTP client to call Pinata API |
| `form-data` | Multipart form builder for file upload |
| `dotenv` | Securely load API keys from `.env` |

---


## How Files Are Stored & Retrieved

### Storage (Upload)
1. A local file is read as a stream using `fs.createReadStream()`.
2. It is wrapped in a `FormData` object with Pinata metadata.
3. A `POST` request is sent to `https://api.pinata.cloud/pinning/pinFileToIPFS`.
4. Pinata pins the file to IPFS and returns a **CID** (Content Identifier).
5. The file is now accessible via any IPFS gateway using its CID.

### Retrieval
- Access the file at: `https://gateway.pinata.cloud/ipfs/<CID>`
- Or via public gateway: `https://ipfs.io/ipfs/<CID>`
- The CID is a unique hash — if the file changes, the CID changes (content-addressed).

---


## IPFS Hash Examples

| File | CID (Example) | Gateway Link |
|---|---|---|
| sample.txt | `bafkreigh2akiscaildcqabr...` | https://ipfs.io/ipfs/bafkreigh2akiscaildcqabr... |

> ⚠️ Replace with your actual CID after running `upload.js`

---


## How to Run

### 1. Install Dependencies
```bash
npm init -y
npm install axios form-data dotenv
```

### 2. Set Up `.env`
Create a `.env` file with your Pinata keys (get free keys at https://pinata.cloud):
```
PINATA_API_KEY=your_api_key_here
PINATA_SECRET_KEY=your_secret_key_here
```

### 3. Upload the File
```bash
node upload.js
```

Expected output:
```
📤 Uploading "sample.txt" to IPFS via Pinata...
✅ Upload Successful!
📎 CID: bafkrei...
🔗 View: https://gateway.pinata.cloud/ipfs/bafkrei...
📄 File Content: This is a sample file...
```

---


## Files Included

| File | Purpose |
|---|---|
| `upload.js` | Main script – uploads file and retrieves it back |
| `sample.txt` | Sample text file to upload to IPFS |

---


## Screenshots
> Add the following screenshots in this folder:
- `screenshot-upload-success.png` – Terminal showing CID and gateway link after upload
- `screenshot-cid-link.png` – Browser showing the file accessed via IPFS gateway
- `screenshot-transaction-events.png` – Event page on blockchain explorer (if CID stored on-chain)

---


## Notes
- Never commit your `.env` file — add it to `.gitignore`
- CIDs are permanent and content-addressed: same content = same CID
- Pinata free tier supports up to 1GB of pinned storage
