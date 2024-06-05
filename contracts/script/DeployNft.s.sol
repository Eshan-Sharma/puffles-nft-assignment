// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {NFT} from "src/NFT.sol";

contract DeployNFT is Script {
    function run() external {
        vm.startBroadcast();
        NFT myNFT = new NFT(msg.sender);
        vm.stopBroadcast();
    }
}
