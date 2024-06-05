// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {NFT} from "../src/NFT.sol";

contract NFTTest is Test {
    NFT nft;

    address ALICE = makeAddr("alice");
    address BOB = makeAddr("bob");
    uint256 public constant MAX_SUPPLY = 10;
    uint256 public constant MINT_PRICE = 0.01 ether;
    uint256 public constant MAX_PER_WALLET = 2;

    function setUp() public {
        nft = new NFT(ALICE);
    }

    function testSafeMintSuccessful() public {
        vm.deal(ALICE, 1 ether); // Provide user1 with sufficient funds

        vm.prank(ALICE);
        uint256 tokenId = nft.safeMint{value: MINT_PRICE}(ALICE, "ipfs://example-uri");

        assertEq(tokenId, 0); // Assuming the first tokenId is 0
        assertEq(nft.balanceOf(ALICE), 1);
        assertEq(nft.tokenURI(tokenId), "ipfs://example-uri");
    }
}
