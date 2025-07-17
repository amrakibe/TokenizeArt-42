# Project Overview

This project includes two separate minting flows for NFTs:

---

## 🧬 On-Chain NFT Minting

### Overview

On-chain NFTs store all metadata and SVG images directly on the blockchain. This approach ensures data permanence and doesn't rely on any external storage like IPFS.

### Key Features

* SVG image generation embedded in the smart contract
* Metadata and images encoded in Base64
* Fully self-contained NFTs compatible with platforms like OpenSea
* Minting restricted to the contract owner

### Smart Contract

* Written in Solidity using `ERC721URIStorage`
* Includes `mintOnChain()` function for generating NFTs entirely on-chain

### Deployment & Usage

* Deployed using Remix IDE
* Frontend built with HTML & JavaScript
* Uses MetaMask and Web3.js for interaction

---

## 🗃️ Off-Chain NFT Minting

### Overview

Off-chain NFTs store metadata and images externally using platforms like IPFS (e.g., Pinata). The NFT only contains a reference (URI) to this data.

### Key Features

* Lightweight metadata storage
* Uses IPFS links for image and metadata
* Suitable for complex assets like high-res images or audio files

### Smart Contract

* Includes `mintOffChain()` function
* Accepts a `dataURI` pointing to IPFS metadata

### Deployment & Usage

* Upload image and JSON metadata to Pinata or similar
* Store the IPFS link in the NFT
* Interact using Remix IDE

---

Each minting method serves a unique purpose. On-chain minting is ideal for immutable and minimal data NFTs, while off-chain minting is more flexible and scalable for complex assets.

Let me know if you'd like these two overviews moved into separate markdown files or sections.
