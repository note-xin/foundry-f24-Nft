//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {Nft} from "src/Nft.sol";
import {DNft} from "src/DNft.sol";

/**
 * @dev This script interacts with the contract
 * @notice this contract dose not have any network config
 */
contract MintNft is Script {
    /* State Variables */
    string public constant NERO_URI = 
        "ipfs://bafybeieii5ky5d2vj54qw3e46r3stljjgqllcpu55hw4m6vqposydwl6cy/?filename=1.NERO.json";
    string public constant KURO_URI = 
        "ipfs://bafybeiga2rj76htutepki2gh7rhgena4kpuetbx236ltxzsfcyqfyfpcgq/?filename=2.KURO.json";

    /* Functions */
    /* External Functions */
    function run() external {
        address recentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "Nft", 
            block.chainid
        );
    
        mintNftOnContract(recentlyDeployed);
    }

    function mintNftOnContract(address _contract) public {
        vm.startBroadcast();
        Nft(_contract).mintNft(NERO_URI);
        Nft(_contract).mintNft(KURO_URI);
        vm.stopBroadcast();
    }
}

contract MintDNft is Script {
    /* Functions */
    /* External Functions */
    function run() external {
        address recentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "DNft", 
            block.chainid
        );
    
        mintDNftOnContract(recentlyDeployed);
    }

    function mintDNftOnContract(address _contract) public {
        vm.startBroadcast();
        DNft(_contract).mintNft();
        vm.stopBroadcast();
    }
}

contract OtherCat is Script {
    /* State Variables */
    uint256 public constant ID_TO_CHANGE = 0;

    /* Functions */
    /* External Functions */
    function run() external {
        address recentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "DNft", 
            block.chainid
        );
    
        otherCatOnContract(recentlyDeployed);
    }

    function otherCatOnContract(address _contract) public {
        vm.startBroadcast();
        DNft(_contract).otherCat(ID_TO_CHANGE);
        vm.stopBroadcast();
    }
}