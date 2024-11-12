// SPDX-LIcense-Identifier: MIT

pragma solidity 0.8.28;

import {Script} from "forge-std/Script.sol";
import {BasicNFT} from "src/BasicNFT.sol";

contract DeployScriptBaseNFT is Script {
    BasicNFT public basicNFT;

    function run() external returns (BasicNFT) {
        vm.startBroadcast();
        basicNFT = new BasicNFT("Neko", "Cat");
        vm.stopBroadcast();

        return basicNFT;
    }
}
