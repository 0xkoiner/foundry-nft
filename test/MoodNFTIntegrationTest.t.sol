// SPDX-License-Identifier: MIT

pragma solidity 0.8.28;

import {Test, console} from "forge-std/Test.sol";
import {DeployMoodNFT} from "script/DeployMoodNFT.s.sol";
import {MoodNFT} from "src/MoodNFT.sol";

contract MoodNFTIntagrationTest is Test {
    DeployMoodNFT deployMoodNFT;
    MoodNFT moodNFT;
    address addressA = makeAddr("addressA");

    function setUp() public {
        deployMoodNFT = new DeployMoodNFT();
        moodNFT = deployMoodNFT.run();
    }

    function testViewTokenURI() public {
        vm.startPrank(addressA);
        moodNFT.mintNFT();
        console.log(moodNFT.tokenURI(0));
    }
}
