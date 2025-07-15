//  SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {ERC721URIStorage, ERC721} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import  "@openzeppelin/contracts/access/Ownable.sol";


import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

contract Amrakibe42 is ERC721URIStorage, Ownable {
    uint256  _nextTokenId;

    constructor() ERC721("Amrakibe42", "AM42") Ownable(msg.sender) {}

    function mintOfChainNft(address to, string memory _tokenURI)  public onlyOwner isValidAddress(to) {
        uint256 tokenId = _nextTokenId++;
        _mint(to, tokenId);
        _setTokenURI(tokenId, _tokenURI);
    }

    function  MintOnChainNFT(address to, uint URI) public onlyOwner{
        _mint(to, URI);
    }

    modifier isValidAddress(address value) {
        require(value != address(0), "Invalid recipient address");
        _;
    }

    function tokenURI(uint256 tokenId) public view override  returns (string memory) {
        return super.tokenURI(tokenId);
    }

    function _baseTokenURI() internal pure returns (string memory) {
    // This is where you can add custom logic or data fetching if needed
    }
}

