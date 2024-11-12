// SPDX-License-Identifier: MIT

pragma solidity 0.8.28;

import {Script} from "forge-std/Script.sol";
import {BasicNFT} from "src/BasicNFT.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

contract MintBasicNFT is Script {
    BasicNFT public basicNFT;
    string public constant URI_LINK =
        "https://ipfs.io/ipfs/QmPgyK6FbkiVdYja8d4LBpseP35df2ALw8RzeebkAy9FmB";

    function run() external returns (BasicNFT) {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "BasicNFT",
            block.chainid
        );
        mintNFRonContract(mostRecentlyDeployed);
    }

    function mintNFRonContract(address _contractAddress) public {
        vm.startBroadcast(_contractAddress);
        BasicNFT(_contractAddress).mintNFT(URI_LINK);
        vm.stopBroadcast();
    }
}
