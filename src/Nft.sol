//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

/** 
 * @title Nft
 * @author note-xin
 * @notice this contract is a section of cyfrin-foundry-course-f23
 * @dev Implements ERC721 token standard: https://eips.ethereum.org/EIPS/eip-721
*/
contract Nft is ERC721 {
    /* State Variable */
    uint256 private  s_tokenId;

    string private constant NAME = "CATZI";
    string private constant SYMBOL = "NYA";

    mapping(uint256 tokenId => string tokenUri) private s_tokenToURI;

    /* Error */
    error Nft__TokenUriNotFound();

    /* Functions */
    /* Constructor */
    constructor () ERC721(NAME, SYMBOL) {
        s_tokenId = 0;
    }

    /* Public Functions */
    function mintNft(string memory tokenUri) public {
        s_tokenToURI[s_tokenId] = tokenUri;
        _safeMint(msg.sender, s_tokenId);

        s_tokenId++;
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        if (ownerOf(tokenId) == address(0)) {
            revert Nft__TokenUriNotFound();
        }
        return s_tokenToURI[tokenId];
    }

    /* Getter Functions */
    function getCollectionName() public pure returns (string memory) {
        return NAME;
    }

    function getCollectionSymbol() public pure returns (string memory) {
        return SYMBOL;
    }

    function getTokenId() public view returns (uint256) {
        return s_tokenId;
    }
}