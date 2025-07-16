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
        _mint(recipient, id);
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
    
    function createSVG() internal view returns (string memory) {
        string memory result = string(
            abi.encodePacked(
                '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 10 10">',
                '<rect width="100%" height="100%" fill="#ffffff"/>',
                '<text x="50%" y="50%" font-family="Arial" font-size="2" fill="#000000" ',
                'text-anchor="middle" dominant-baseline="middle">',
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