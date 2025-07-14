//  SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC721URIStorage, ERC721} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import  "@openzeppelin/contracts/access/Ownable.sol";

contract Amrakibe42 is ERC721URIStorage, Ownable {
    uint256  _nextTokenId;

    constructor() ERC721("Amrakibe42", "AM42") Ownable(msg.sender) {}

    function awardItem(address to, string memory tokenURI) onlyOwner public  {
        uint256 tokenId = _nextTokenId++;
        _mint(to, tokenId);
        _setTokenURI(tokenId, tokenURI);
    }
}