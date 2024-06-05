// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {NFT} from "../src/NFT.sol";
import {HelperConfig} from "script/HelperConfig.s.sol";
import {DeployNFT} from "script/DeployNft.s.sol";

contract NFTTest is Test {
    NFT public nft;
    HelperConfig public config;
    DeployNFT public deployer;

    address ALICE = makeAddr("alice");
    address BOB = makeAddr("bob");
    address USER = makeAddr("user");
    uint256 public constant STARTING_USER_BALANCE = 1 ether;
    uint256 public constant MAX_SUPPLY = 10;
    uint256 public constant MINT_PRICE = 0.01 ether;
    uint256 public constant MAX_PER_WALLET = 2;

    function setUp() public {
        deployer = new DeployNFT();
        (nft, config) = deployer.run();
        if (block.chainid == 31337) {
            vm.deal(USER, STARTING_USER_BALANCE);
        }
    }

    function testSafeMintSuccessful() public {
        vm.deal(ALICE, 1 ether); // Provide user1 with sufficient funds

        vm.prank(ALICE);
        uint256 tokenId = nft.safeMint{value: MINT_PRICE}(ALICE, "ipfs://example-uri");

        assertEq(tokenId, 0); // Assuming the first tokenId is 0
        assertEq(nft.balanceOf(ALICE), 1);
        assertEq(nft.tokenURI(tokenId), "ipfs://example-uri");
    }

    function testMaxMintPerWalletReached() public {
        nft.safeMint{value: MINT_PRICE}(address(0x01), "ipfs://example-uri");
        nft.safeMint{value: MINT_PRICE}(address(0x01), "ipfs://example-uri");
        vm.expectRevert(NFT.NFT_MaxMintPerWalletReached.selector);
        nft.safeMint{value: MINT_PRICE}(address(0x02), "ipfs://example-uri");
    }

    function testMaxSupplyReached() public {
        // Mint maximum supply first
        address[] memory users = new address[](MAX_SUPPLY);

        for (uint256 i = 0; i < MAX_SUPPLY; i++) {
            users[i] = address(uint160(i + 1));
            vm.deal(users[i], 1 ether); // Provide each user with sufficient funds
            vm.prank(users[i]);
            nft.safeMint{value: MINT_PRICE}(users[i], "ipfs://example-uri");
        }

        address newUser = address(uint160(MAX_SUPPLY + 1));
        vm.deal(newUser, 1 ether);
        vm.prank(newUser);
        vm.expectRevert(NFT.NFT__MaxSupplyReached.selector);
        nft.safeMint{value: MINT_PRICE}(newUser, "ipfs://example-uri");
    }

    function testInsufficientEtherSent() public {
        vm.expectRevert(NFT.NFT__InsufficientEtherSent.selector);
        nft.safeMint{value: 0.009 ether}(ALICE, "ipfs://example-uri");
    }
}
