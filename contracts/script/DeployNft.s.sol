// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {NFT} from "src/NFT.sol";
import {HelperConfig} from "script/HelperConfig.s.sol";

contract DeployNFT is Script {
    function run() external returns (NFT, HelperConfig) {
        HelperConfig config = new HelperConfig();
        uint256 deployerKey = config.activeNetworkConfig();

        vm.startBroadcast(deployerKey);
        NFT nft = new NFT(msg.sender);
        vm.stopBroadcast();
        return (nft, config);
    }
}
