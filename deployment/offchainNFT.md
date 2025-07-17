# Off-Chain Minting 

This guide explains how to mint NFTs with off-chain metadata and images hosted on **Pinata (IPFS)** using Remix and your `Amrakibe42` contract’s `mintOffChain` function.

---

## 1. Upload Assets to Pinata

- Go to [https://pinata.cloud](https://pinata.cloud) and log in or create an account.
- Upload your NFT image (e.g., PNG, JPEG, SVG).
- Upload your metadata JSON file referencing the uploaded image's IPFS hash.

Example metadata JSON:

```json
{
  "name": "My NFT Title",
  "description": "Description of my NFT",
  "image": "ipfs://QmImageHashHere",
  "attributes": [
    {
      "trait_type": "Artist",
      "value": "YourName"
    }
  ]
}
```
- Pinata will provide IPFS hashes (CIDs) for both files.

#### 2. Get the Metadata URI
- Copy the IPFS URI for your metadata JSON, for example:
``` cpp
ipfs://QmMetadataHashHere
```
- This URI will be used as the dataURI when minting.

#### 3. Mint Using Remix
- Open your Amrakibe42 contract in Remix and deploy it.

- In the deployed contract’s interface, find the mintOffChain function.

- Enter:

    - recipient: Your wallet address (or the address you want to own the NFT).

    - dataURI: The IPFS URI of your metadata JSON from Pinata (e.g., ipfs://QmMetadataHashHere...).

- Execute the transaction and confirm it in your wallet.

#### 4. Verify
- Once mined, your NFT’s token URI will point to the metadata hosted on IPFS via Pinata.

- Marketplaces like OpenSea will fetch and display your NFT details from that URI.


#### Tips
- Use gateways like https://gateway.pinata.cloud/ipfs/bafkreie4... if you want to preview metadata in a browser.

- Ensure your metadata JSON strictly follows the ERC-721 Metadata Standard.