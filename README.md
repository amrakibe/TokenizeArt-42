# 🖼️ TokenizeArt Project

## 🔍 Overview

**TokenizeArt** is a dual-mode ERC721 NFT smart contract built using Solidity and OpenZeppelin libraries. It enables two NFT minting approaches:

1. **Off-chain minting** using external metadata (like IPFS or custom URIs)
2. **Fully on-chain minting** with SVG-based visuals and metadata directly embedded on the blockchain

---

## 🛠️ Language & Tools

### 🧠 Language

**Solidity**  
Chosen for its:

- Native compatibility with the Ethereum Virtual Machine (EVM)
- Built-in arithmetic protections (overflow/underflow)
- Rich ecosystem and community support

### 🔧 Development Tools

Developed using **Remix IDE**, which provides:

- Web-based accessibility
- One-click compilation and deployment
- Seamless testing and debugging
- Import support for OpenZeppelin contracts

---

## 📁 Project Structure

```
Amrakibe42/
├── mintnft/
│   └── Amrakibe42.sol              
├── mintnft-ui/                      
│   └── index.html                   
├── deployment/
│   └── README.md
environment details
├── documentation/
│   ├── mintOffChain.md
│   └── mintOnChain.md
└── README.md
```

---

## 🔐 Smart Contract Features

### ✅ Dual Minting System

| Function         | Description |
|------------------|-------------|
| `mintOffChain`   | Mints an NFT using external metadata (like IPFS `dataURI`) |
| `mintOnChain`    | Fully on-chain minting with auto-generated SVG & metadata |

### 🧩 On-Chain Components

- SVG image generation from input text
- Metadata structured and Base64 encoded
- `getTokenURI()` returns `data:application/json;base64,...`

### 🔒 Security

- `Ownable` pattern to restrict minting access
- `_safeMint()` ensures only EOAs or compatible contracts can receive NFTs
- Input validation using `isValidAddress` modifier

---

## 🧱 Technical Design Details

### 1. Struct Organization

```solidity
struct Attribute {
    string traitType;
    string value;
}

struct TokenData {
    string title;
    string info;
    string visual;
    string creator;
}
```

- `TokenData`: Stores NFT metadata before it is Base64 encoded.
- `Attribute`: Prepares for extensible trait modeling (used in JSON metadata).

### 2. SVG-Based On-Chain Metadata

```svg
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 10 10">
  <rect width="100%" height="100%" fill="#ffffff"/>
  <text x="50%" y="50%" font-family="Arial" font-size="2" fill="#000000"
        text-anchor="middle" dominant-baseline="middle">
    {{visual}}
  </text>
</svg>
```

- Minimal design for gas efficiency
- Dynamic content from `visual` field

### 3. Metadata JSON Format

```json
{
    "name": "Amrakibe42",
    "description": "Simple description for your NFT.",
    "image": ["ipfs://bafybei..."],
    "attributes": [
      {
        "trait_type": "Artist",
        "value": "amrakibe"
      }
    ]
}
```

### 4. Base64 Encoding

- SVG and metadata JSON are encoded using OpenZeppelin's `Base64.sol`.
- Enables complete self-contained NFTs for on-chain storage.

---

## 🌐 Website Integration

### Key Frontend Features

- Wallet connection (e.g. MetaMask)
- UI for entering `title`, `info`, `visual`, `creator`
- Trigger on-chain mint via Web3.js or Ethers.js
- Transaction feedback and error handling

---

## 🚀 Deployment Guide

### Step 1: Deploy the Contract on Remix

1. Open [Remix Ethereum IDE](https://remix.ethereum.org/)
2. Create a new file: `Amrakibe42.sol`
3. Paste the smart contract code
4. Compile with **Solidity 0.8.30+**
5. Deploy using **Injected Web3** with MetaMask

### Step 2: Test Minting

- Call `mintOnChain("Art Title", "Info", "Visual", "Creator")`
- Copy returned `tokenURI` and preview it via JSON visualizer or OpenSea testnet

## 🌐 Website Frontend Description: On-Chain NFT Minting Interface
This simple web page provides a user-friendly interface for minting NFTs directly on-chain using the mintOnChain function of the deployed Amrakibe42 smart contract.

### Key Features:
- MetaMask Wallet Connection.
- Minting Form.
- Interaction with Smart Contract.

---

## 📚 Usage Docs
- [how to deployment](./deployment/README.md)
- [on chain explaing](./documentation/onchainNFT.md)
- [offchain explaning](./documentation/offchainNFT.md)
<!-- - [Usage Guide](./documentation/USAGE.md)
- [On-Chain Metadata Explanation](./documentation/ONCHAIN_METADATA_EXPLAINED.md) -->

