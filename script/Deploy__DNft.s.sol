//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {DNft} from "src/DNft.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

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
    function run() external returns (DNft) {
        /* Before Broadcast */
        string memory kuro_svg = vm.readFile("./assets/svg/KURO_B.svg");
        string memory nero_svg = vm.readFile("./assets/svg/NERO_B.svg");

        if (block.chainid == 31337) {
            deployerKey = DEFAULT_ANVIL_PRIVATE_KEY;
        } else {
            deployerKey = vm.envUint("PRIVATE_KEY");
        }

        /* Broadcast */
        vm.startBroadcast(deployerKey);
        DNft dnft = new DNft(
            svgToImageURI(kuro_svg),
            svgToImageURI(nero_svg)
        );
        vm.stopBroadcast();

        /* After Broadcast */
        return dnft;
    }

    /* Public Functions */
    function svgToImageURI(string memory svg) public pure returns (string memory) {
        string memory baseUri = "data:image/svg+xml;base64,";
        string memory base64EncodedSvg = Base64.encode(
            bytes(
                string(abi.encodePacked(svg))
            )
        );
        return string(
            abi.encodePacked(
                baseUri, 
                base64EncodedSvg
            )
        );
    }
}