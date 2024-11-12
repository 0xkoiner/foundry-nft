// SPDX-License-Identifier: MIT

pragma solidity 0.8.28;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

/**
 * @title Basic NFT
 * @author 0xKoiner
 * @notice This contract is for creating a sample NFT
 * @dev Implements @penzeppelin ERC721.sol
 */
contract BasicNFT is ERC721 {
    /** State Vars */
    uint256 private s_tokenCounter; /// @dev s_tokenCounter for counting how many tokens minted
    mapping(uint256 => string) private s_tokenIdToURI; /// @dev s_tokenIdToURI mapping key: tokenId value: token URI

    /** Functions */
    /// @param _name Name of the NFT contract
    /// @param _symbol Symbol of the NFT contract
    /// @dev Initializes the contract by setting a `name` and a `symbol` to the token collection.
    constructor(
        string memory _name,
        string memory _symbol
    ) ERC721(_name, _symbol) {
        s_tokenCounter = 0;
    }

    /// @notice Function for mint new NFT
    /// @param _tokenURI Token URI the ipfs link
    /// @dev Function using inner function _safeMint of @penzeppelin ERC721.sol lib
    function mintNFT(string memory _tokenURI) public {
        s_tokenIdToURI[s_tokenCounter] = _tokenURI;
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenCounter++;
    }

    /// @notice Function for view a token URI
    /// @param _tokenId Token id of minted NFT
    /// @return string of URI / ipfs link
    /// @dev Function using inner function _safeMint of @penzeppelin ERC721.sol lib
    /// QmPgyK6FbkiVdYja8d4LBpseP35df2ALw8RzeebkAy9FmB
    function tokenURI(
        uint256 _tokenId
    ) public view override returns (string memory) {
        return s_tokenIdToURI[_tokenId];
    }
}
