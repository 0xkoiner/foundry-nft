// SPDX-License-Identifier: MIT

pragma solidity 0.8.28;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

/**
 * @title MoodNFT NFT
 * @author 0xKoiner
 * @notice This contract is for creating a sample NFT
 * @dev Implements @penzeppelin ERC721.sol
 */
contract MoodNFT is ERC721 {
    /** Errors */
    error MoodNFT__CantChangeNoodIfNotOwnerOrApproved();

    /** Type Declarations */
    enum Mood {
        HAPPY,
        SAD
    }

    /** State Vars */
    uint256 private s_tokenCounter; /// @dev s_tokenCounter for counting how many tokens minted
    mapping(uint256 => Mood) private s_tokenIdToMood; /// @dev s_tokenIdToMood mapping key: tokenId value: token Mood
    string private s_sadSVGImageURI; /// @dev s_sadSVG code of SVG for sad smily
    string private s_happySVGImageURI; /// @dev _happySVG code of SVG for happy smily

    /** Functions */
    /// @param _name Name of the NFT contract
    /// @param _symbol Symbol of the NFT contract
    /// @dev Initializes the contract by setting a `name` and a `symbol` to the token collection.
    constructor(
        string memory _name,
        string memory _symbol,
        string memory _sadSVGImageURI,
        string memory _happySVGImageURI
    ) ERC721(_name, _symbol) {
        s_tokenCounter = 0;
        s_sadSVGImageURI = _sadSVGImageURI;
        s_happySVGImageURI = _happySVGImageURI;
    }
    /** Setter Functions */
    /// @notice Function for mint new NFT
    /// @param _tokenURI Token URI the ipfs link
    /// @dev Function using inner function _safeMint of @penzeppelin ERC721.sol lib
    function mintNFT(string memory _tokenURI) public {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenIdToMood[s_tokenCounter] = Mood.HAPPY;
        s_tokenCounter++;
    }

    function changeMood(uint256 _tokenId) public {
        if (!_isAuthorized(msg.sender, msg.sender, _tokenId)) {
            revert MoodNFT__CantChangeNoodIfNotOwnerOrApproved();
        }
        if (s_tokenIdToMood[_tokenId] == Mood.HAPPY) {
            s_tokenIdToMood[_tokenId] == Mood.SAD;
        } else {
            s_tokenIdToMood[_tokenId] == Mood.HAPPY;
        }
    }

    /**
     * @dev Base URI for computing {tokenURI}. If set, the resulting URI for each
     * token will be the concatenation of the `baseURI` and the `tokenId`. Empty
     * by default, can be overridden in child contracts.
     */
    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64";
    }

    /// @notice Function for view a token URI
    /// @param _tokenId Token id of minted NFT
    /// @return string of URI / ipfs link
    /// @dev Function using inner function _safeMint of @penzeppelin ERC721.sol lib
    /// QmPgyK6FbkiVdYja8d4LBpseP35df2ALw8RzeebkAy9FmB
    function tokenURI(
        uint256 _tokenId
    ) public view override returns (string memory) {
        string memory _imageURI;

        if (s_tokenIdToMood[_tokenId] == Mood.HAPPY) {
            _imageURI = s_happySVGImageURI;
        } else {
            _imageURI = s_sadSVGImageURI;
        }

        return
            string(
                abi.encodePacked(
                    _baseURI(),
                    Base64.encode(
                        bytes(
                            abi.encodePacked(
                                '{"name": "',
                                name(),
                                '", "description": "An NFT shows and owners mood.", "attributes:" [{trait_type: "moodiness", "value": 100}], "image": "',
                                _imageURI,
                                '"}'
                            )
                        )
                    )
                )
            );
    }
}
