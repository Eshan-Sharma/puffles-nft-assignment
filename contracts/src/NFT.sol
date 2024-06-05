// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

import {ERC721URIStorage} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import {ERC721Enumerable} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract NFT is ERC721, ERC721URIStorage, ERC721Enumerable, Ownable {
    ///////////////////
    //State Variables//
    ///////////////////
    uint256 public constant MAX_SUPPLY = 10;
    uint256 public constant MINT_PRICE = 0.01 ether;
    uint256 public constant MAX_PER_WALLET = 2;

    uint256 private _nextTokenId; //Auto Increment

    mapping(address => uint256) public walletMintCount; //Wallet to token Mapping

    //////////
    //Errors//
    //////////
    error NFT__MaxSupplyReached();
    error NFT_MaxMintPerWalletReached();
    error NFT__InsufficientEtherSent();

    constructor(address initialOwner) ERC721("Puffles", "PUFL") Ownable(initialOwner) {}

    function safeMint(address _to, string calldata _uri) external payable returns (uint256) {
        uint256 tokenId = _nextTokenId++;

        if (totalSupply() >= MAX_SUPPLY) revert NFT__MaxSupplyReached();
        if (walletMintCount[msg.sender] >= MAX_PER_WALLET) revert NFT_MaxMintPerWalletReached();
        if (msg.value < MINT_PRICE) revert NFT__InsufficientEtherSent();

        walletMintCount[msg.sender] += 1;

        _safeMint(_to, tokenId); //Emits Transfer(address(0), to, tokenId)
        _setTokenURI(tokenId, _uri); // Emits MetadataUpdate(tokenId)
        return tokenId;
    }

    // The following functions are overrides required by Solidity.
    function _update(address to, uint256 tokenId, address auth)
        internal
        override(ERC721, ERC721Enumerable)
        returns (address)
    {
        return super._update(to, tokenId, auth);
    }

    function _increaseBalance(address account, uint128 value) internal override(ERC721, ERC721Enumerable) {
        super._increaseBalance(account, value);
    }

    function tokenURI(uint256 tokenId) public view override(ERC721, ERC721URIStorage) returns (string memory) {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable, ERC721URIStorage)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
