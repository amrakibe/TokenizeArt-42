# On-Chain Minting Guide (`mintOnChain`)

This guide explains how to mint fully **on-chain NFTs** using the `mintOnChain` function in your `Amrakibe42` smart contract. It includes an overview of on-chain storage, user flow, and frontend usage.

---

## Overview

The `mintOnChain` function allows users (only the contract owner) to mint NFTs where:

* All metadata is stored on-chain.
* The image is an SVG string encoded directly inside the token URI.
* No reliance on external servers (e.g., IPFS or Pinata).

---

## Function Signature

```solidity
function mintOnChain(
  string memory title,
  string memory info,
  string memory visual,
  string memory creator
) public onlyOwner
```

### Parameters:

| Parameter | Description                    |
| --------- | ------------------------------ |
| `title`   | Name or title of the NFT       |
| `info`    | Description of the NFT         |
| `visual`  | SVG image content (text-based) |
| `creator` | Artist or creator name         |

---

## How It Works

1. **Metadata Storage**:

   * The contract uses a `TokenData` struct to temporarily store metadata.
   * Example:

     ```solidity
     TokenData({
       title: "Sunset",
       info: "A beautiful SVG NFT",
       visual: "<svg>...</svg>",
       creator: "Amine"
     });
     ```

2. **SVG Rendering**:

   * A function `createSVG()` dynamically generates an SVG image with `visual` as its content.

3. **Token URI Generation**:

   * `getTokenURI()` encodes the metadata and image as Base64 JSON using OpenZeppelin's `Base64` utility.
   * Result: The token URI is a `data:application/json;base64,...` string.

4. **Minting**:

   * The NFT is safely minted to the contract owner (`msg.sender`) with `_safeMint`.

---

## Frontend Usage

You already have a web interface for minting on-chain NFTs. Here's how the flow works:

### Connect Wallet

```javascript
await window.ethereum.request({ method: "eth_requestAccounts" });
```

### Collect Form Data

```javascript
const title = document.getElementById("title").value;
const info = document.getElementById("info").value;
const visual = document.getElementById("visual").value;
const creator = document.getElementById("creator").value;
```

### Call Contract Method

```javascript
contract.methods
  .mintOnChain(title, info, visual, creator)
  .send({ from: accounts[0], gasPrice: 3500000 });
```

---

## Example SVG

When entering `visual`, you can write plain text or raw SVG code.

**Example `visual` input (text-based):**

```text
Hello Web3!
```

This will render an SVG like:

```xml
<svg ...>
  <text ...>Hello Web3!</text>
</svg>
```

---

## Benefits of On-Chain NFTs

* Fully decentralized: No IPFS, no backend.
* Permanent: All NFT data lives on the blockchain forever.
* Self-contained: Easy to verify authenticity and content.

---

## Limitations

* Only the `owner` (i.e., the deployer) can mint.
* Each mint overwrites the previous `TokenData` struct.
* Currently no per-token metadata mapping – future improvement possible.

---
