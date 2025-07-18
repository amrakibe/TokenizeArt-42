// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {ERC721URIStorage, ERC721} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

contract Amrakibe42 is ERC721URIStorage, Ownable {
    uint256 public currentId;
    
    constructor() ERC721("Amrakibe42", "AM42") Ownable(msg.sender) {}
    
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
    
    TokenData public metadata;
    
    modifier isValidAddress(address addr) {
        require(addr != address(0), "Invalid recipient address");
        _;
    }
    
    function mintOffChain(address recipient, string memory dataURI) public onlyOwner isValidAddress(recipient) {
        uint256 id = currentId++;
        _safeMin(recipient, id);
        _setTokenURI(id, dataURI);
    }
    
    function mintOnChain(
        string memory title,
        string memory info,
        string memory visual,
        string memory creator
    ) public onlyOwner   {
        uint256 id = currentId++;
        
        metadata = TokenData({
            title: title,
            info: info,
            visual: visual,
            creator: creator
        });
    
        _safeMint(msg.sender, id);
        _setTokenURI(id, getTokenURI());
    }

    
function createSVG() internal view  returns (string memory) {
    string memory result = string(
        abi.encodePacked(
            '<svg id="visual" viewBox="0 0 900 600" width="900" height="600" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1">'
            '<rect x="0" y="0" width="900" height="600" fill="#FF0066"></rect>'
            '<g transform="translate(406.32963196009666 322.44729477043194)">'
            '<path d="M144.2 -146.2C192.2 -96.2 240.1 -48.1 237.5 -2.6C234.9 42.9 181.8 85.8 133.8 123.3C85.8 160.8 42.9 192.9 -4.8 197.7C-52.6 202.6 -105.1 180.1 -130.1 142.6C-155.1 105.1 -152.6 52.6 -145.1 7.4C-137.7 -37.7 -125.4 -75.4 -100.4 -125.4C-75.4 -175.4 -37.7 -237.7 5.2 -242.9C48.1 -248.1 96.2 -196.2 144.2 -146.2" fill="#BB004B"></path></g>'
            '<text x="450" y="300" dominant-baseline="middle" text-anchor="middle" fill="white" font-size="120" font-weight="bold">',
            metadata.visual,
            '</text></svg>'
        )
    );
    return result;
}

    function getTokenURI() public view returns (string memory) {
        string memory encoded = Base64.encode(bytes(createSVG()));
        
        return string(
            abi.encodePacked(
                "data:application/json;base64,",
                Base64.encode(bytes(abi.encodePacked(
                    '{"name":"', metadata.title, '",',
                    '"description":"', metadata.info, '",',
                    '"image":"data:image/svg+xml;base64,', encoded, '",',
                    '"attributes":[{"trait_type":"Creator","value":"', metadata.creator, '"}]}'
                )))
            )
        );
    }
}