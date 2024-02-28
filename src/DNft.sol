//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

/** 
 * @title Dynamic Nft
 * @author note-xin
 * @notice this contract is a section of cyfrin-foundry-course-f23
 * @dev Implements ERC721 token standard: https://eips.ethereum.org/EIPS/eip-721
*/
contract DNft is ERC721 {
    /* State Variable */
    uint256 private  s_tokenId;

    string private constant NAME = "CATZI";
    string private constant SYMBOL = "NYA";
    string private s_KURO_imageUri;
    string private s_NERO_imageUri;

    enum CATZI {
        KURO,
        NERO
    }

    mapping(uint256 tokenId => CATZI) private s_tokenToCATZI;

    /* Error */
    error DNft__TokenUriNotFound();
    error DNft__NotApprovedOrOwner();

    /* Functions */
    /* Constructor */
    constructor (
        string memory KURO_imageUri, 
        string memory NERO_imageUri
    ) ERC721(NAME, SYMBOL) {
        s_tokenId = 0;
        s_KURO_imageUri = KURO_imageUri;
        s_NERO_imageUri = NERO_imageUri;
    }

    /* Public Functions */
    function mintNft() public {
        s_tokenToCATZI[s_tokenId] = CATZI.KURO;
        _safeMint(msg.sender, s_tokenId);

        s_tokenId++;
    }

    function otherCat(uint256 _tokenId) public {
        if (getApproved(_tokenId) != msg.sender && ownerOf(_tokenId) != msg.sender) {
            revert DNft__NotApprovedOrOwner();
        }

        if (s_tokenToCATZI[_tokenId] == CATZI.KURO) {
            s_tokenToCATZI[_tokenId] = CATZI.NERO;
        } else {
            s_tokenToCATZI[_tokenId] = CATZI.KURO;
        }
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        string memory imageURI;

        if (ownerOf(tokenId) == address(0)) {
            revert DNft__TokenUriNotFound();
        }

        if (s_tokenToCATZI[tokenId] == CATZI.KURO) {
            imageURI = s_KURO_imageUri;
        } else {
            imageURI = s_NERO_imageUri;
        }
            
        return string(
            abi.encodePacked(
                _baseURI(),
                Base64.encode(
                    abi.encodePacked(
                        '{"name": "', 
                        name(),
                        '", "description": "A collection of CATZI NFTs.", ',
                        '"attributes": [{"trait_type": "CATZI", "value": SSS"}], "image": "', 
                        imageURI,
                        '"}'
                    )
                )
            )
        );
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
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