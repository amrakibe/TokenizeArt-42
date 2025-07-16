// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {ERC721URIStorage, ERC721} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

contract Amrakibe42 is ERC721URIStorage, Ownable {
    uint256 public _nextTokenId;
    
    constructor() ERC721("Amrakibe42", "AM42") Ownable(msg.sender) {}
    
    struct Attribute {
        string trait_type;
        string value;
    }
    
    struct NFTMetadata {
        string name;
        string description;
        string image;
        string artist;
    }
    
    NFTMetadata public _tokenMetadata;
    
    modifier isValidAddress(address value) {
        require(value != address(0), "Invalid recipient address");
        _;
    }
    
    function mintOffChainNft(address to, string memory _tokenURI) public onlyOwner isValidAddress(to) {
        uint256 tokenId = _nextTokenId++;
        _mint(to, tokenId);
        _setTokenURI(tokenId, _tokenURI);
    }
    
    function mintOnChain(
        string memory _name,
        string memory _description,
        string memory _svgImage,
        string memory _artist
    ) public onlyOwner   {
        uint256 tokenId = _nextTokenId++;
        
        _tokenMetadata = NFTMetadata({
            name: _name,
            description: _description,
            image: _svgImage,
            artist: _artist
        });
    
        _safeMint(msg.sender, tokenId);
        _setTokenURI(tokenId, tokenURI());
    }
    
    function generateSVG() internal view   returns (string memory) {
        string memory generatedSVG = string(
            abi.encodePacked(
                '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 10 10">',
                '<rect width="100%" height="100%" fill="#ffffff"/>',
                '<text x="50%" y="50%" font-family="Arial" font-size="2" fill="#000000" ',
                'text-anchor="middle" dominant-baseline="middle">',
                _tokenMetadata.image,
                '</text></svg>'
            )
        );
        return generatedSVG;
    }
    
    function tokenURI() public view  returns (string memory) {

        string memory image = Base64.encode(bytes(generateSVG()));
        
        return string(
            abi.encodePacked(
                "data:application/json;base64,",
                Base64.encode(bytes(abi.encodePacked(
                    '{"name":"', _tokenMetadata.name, '",',
                    '"description":"', _tokenMetadata.description, '",',
                    '"image":"data:image/svg+xml;base64,', image, '",',
                    '"attributes":[{"trait_type":"Artist","value":"', _tokenMetadata.artist, '"}]}'
                )))
            )
        );
    }
}