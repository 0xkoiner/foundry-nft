// SPDX-License-Identifier: MIT

pragma solidity 0.8.28;

import {Test} from "forge-std/Test.sol";
import {DeployScriptBaseNFT} from "script/DeployBasicNFT.s.sol";
import {BasicNFT} from "src/BasicNFT.sol";

contract BasicNFTTest is Test {
    DeployScriptBaseNFT public deployer;
    BasicNFT public basicNFT;

    address public addressA = makeAddr("addressA");
    string public constant URI_LINK =
        "https://ipfs.io/ipfs/QmPgyK6FbkiVdYja8d4LBpseP35df2ALw8RzeebkAy9FmB";

    function setUp() public {
        deployer = new DeployScriptBaseNFT();
        basicNFT = deployer.run();
    }

    function testCheckCorrectNameAfterConstructor() public view {
        string memory name = basicNFT.name();
        string memory expectedName = "Neko";
        // assertEq(name, expectedName);

        assert(
            keccak256(abi.encodePacked(name)) ==
                keccak256(abi.encodePacked(expectedName))
        );
    }

    function testCheckCorrectTagAfterConstructor() public view {
        string memory symbol = basicNFT.symbol();
        string memory expectedTag = "Cat";
        // assertEq(symbol, expectedTag);
        assert(
            keccak256(abi.encodePacked(symbol)) ==
                keccak256(abi.encodePacked(expectedTag))
        );
    }

    function testCanMintAndHaveABalance() public {
        vm.startPrank(addressA);
        basicNFT.mintNFT(URI_LINK);
        vm.stopPrank();

        assert(basicNFT.balanceOf(addressA) == 1);
        assert(
            keccak256(abi.encodePacked(URI_LINK)) ==
                keccak256(abi.encodePacked(basicNFT.tokenURI(0)))
        );
    }
}
