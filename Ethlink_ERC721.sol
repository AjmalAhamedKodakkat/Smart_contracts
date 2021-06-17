// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts@4.1.0/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@4.1.0/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts@4.1.0/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts@4.1.0/security/Pausable.sol";
import "@openzeppelin/contracts@4.1.0/access/Ownable.sol";
import "@openzeppelin/contracts@4.1.0/token/ERC721/extensions/ERC721Burnable.sol";


contract ETHLINK_ERC721 is ERC721, ERC721Enumerable, ERC721URIStorage, Pausable, Ownable, ERC721Burnable {
  

 
   
   string private _nftName;
   string private _nftSymbol;
   string private _nftTokenUri;
    
    mapping (address => uint256) internal ownerToId;

    constructor(string memory nftName,string memory nftSymbol, string memory nftTokenUri) ERC721(nftName, nftSymbol) {
        
        _nftName = nftName;
        _nftSymbol = nftSymbol;
        _nftTokenUri=nftTokenUri;
    }

    function safeMint(address to , uint256 tokenId) public onlyOwner {
       _safeMint(to, tokenId);
        ownerToId[to] = tokenId;
    }
    
    function getTokenID(address from) public view returns (uint256) {
        return (ownerToId[from]);
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function _baseURI() internal view override returns (string memory) {
        return _nftTokenUri;
    }

    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        whenNotPaused
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }
    function isExist(uint256 tokenId) public view returns (bool){
       return  _exists(tokenId);
        
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
