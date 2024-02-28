//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {Nft} from "src/Nft.sol";

/**
 * @dev This script deploys the contract
 * @notice this contract dose not have any network config
 */
contract Deploy is Script {
    /* State Variables */
    uint256 public DEFAULT_ANVIL_PRIVATE_KEY = 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80;
    uint256 public deployerKey;

    /* Functions */
    /* External Functions */
    function run() external returns (Nft) {
        /* Before Broadcast */
        if (block.chainid == 31337) {
            deployerKey = DEFAULT_ANVIL_PRIVATE_KEY;
        } else {
            deployerKey = vm.envUint("PRIVATE_KEY");
        }

        /* Broadcast */
        vm.startBroadcast(deployerKey);
        Nft nft = new Nft();
        vm.stopBroadcast();

        /* After Broadcast */
        return nft;
    }
}