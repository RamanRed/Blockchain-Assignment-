# Assignment 4: IPFS Integration

## 📋 Overview

This assignment implements decentralized file storage using **IPFS (InterPlanetary File System)** via the **Pinata** pinning service. Users can upload any file to IPFS and retrieve it using its unique CID (Content Identifier) — all from a simple browser-based interface.

---

## 🛠️ IPFS Service & Library Used

| Tool | Purpose |
|---|---|
| [Pinata](https://pinata.cloud) | IPFS pinning service — keeps files permanently available |
| Pinata REST API | `POST /pinning/pinFileToIPFS` to upload files |
| Browser `fetch()` | Makes API calls directly from the browser |
| IPFS Gateway | `https://gateway.pinata.cloud/ipfs/<CID>` to retrieve files |

No npm packages required — everything runs in plain HTML + JavaScript.

---

## 📁 How Files Are Stored & Retrieved

### 🔼 Storage (Upload)
1. User selects a file from their computer.
2. The file is wrapped in a `FormData` object along with Pinata metadata.
3. A `fetch` POST request is sent to the Pinata API with the API keys in headers.
4. Pinata pins the file to the IPFS network and returns a **CID** (Content Identifier).
5. The CID is displayed with direct gateway links.

### 🔽 Retrieval
1. User enters any valid CID in the retrieve input field.
2. The app fetches from `https://gateway.pinata.cloud/ipfs/<CID>`.
3. If the file is an image, it is displayed as a preview directly in the browser.
4. For other file types, a direct link is provided.

---

## 🔑 IPFS Hash Examples

| File | CID (Example) | Gateway URL |
|---|---|---|
| sample image | `bafkreigh2akiscai...` | https://gateway.pinata.cloud/ipfs/bafkreigh2akiscai... |

> ⚠️ Replace with your actual CID generated after uploading via the app.

---

## 🚀 How to Run

### Option A — Python Server
```bash
cd Assignment4
python -m http.server 3000
```
Open: http://127.0.0.1:3000

### Option B — VS Code Live Server
Right-click `index.html` → **Open with Live Server**

### Steps Inside the App
1. Get your free Pinata API keys from https://pinata.cloud → API Keys
2. Enter **API Key** and **Secret API Key** in the configuration section
3. Select any file using the file picker
4. Click **Upload to IPFS via Pinata**
5. Copy the generated **CID**
6. Paste the CID in the Retrieve section and click **Retrieve from IPFS**

---

## 📁 Files

| File | Description |
|---|---|
| `index.html` | Complete IPFS upload & retrieval DApp (no build tools needed) |

---

## 📸 Screenshots
> Add the following screenshots to this folder:
- `screenshot-upload-success.png` — App showing CID and gateway links after upload
- `screenshot-cid-link.png` — Browser showing the file accessed via IPFS gateway
- `screenshot-transaction-events.png` — Event page on blockchain explorer (transaction link)

---

## 💡 Key Concepts

- **CID** — Content Identifier. A unique cryptographic hash of the file content. Same file = same CID.
- **Content Addressing** — Files are identified by what they contain, not where they are stored.
- **Pinning** — Ensures your file stays on the IPFS network and doesn't get garbage collected.
- **Decentralization** — No single server holds the file; it is distributed across the IPFS network.
