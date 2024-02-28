//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {Deploy} from "script/Deploy__Nft.s.sol";
import {Nft} from "src/Nft.sol";

/**
 * @dev This tests the functionality of our contract
 * @notice note that the `console.log` statements are for debugging purposes comment them out
 */
contract NftTest is Test {
    /* State Variables */
    uint256 public constant STARTING_BALANCE = 100 ether;

    string public constant NERO_URI = 
        "ipfs://bafybeieii5ky5d2vj54qw3e46r3stljjgqllcpu55hw4m6vqposydwl6cy/?filename=1.NERO.json";

    address public immutable i_user = makeAddr("user");

    Deploy public deploy;
    Nft public nft;

    /* Errors */
    error NftTest__DiffrentCollection();


    /* Functions */
    /* External Functions */
    function setUp() external {
        deploy = new Deploy();
        nft = deploy.run();

        vm.deal(i_user, STARTING_BALANCE);
    }

    /* Test Functions */
    function test_verifyNftCollection() public {
        // Arrange
        string memory expectedName = nft.getCollectionName();
        string memory actualName = nft.name();

        // Act & Assert
        if (bytes(expectedName).length != bytes(actualName).length) {
            revert NftTest__DiffrentCollection();
        }
        else {
            assertEq(keccak256(abi.encodePacked(expectedName)), keccak256(abi.encodePacked(actualName)));
        }
    }

    function test_verifyNftSymbol() public {
        // Arrange
        string memory expectedSymbol = nft.getCollectionSymbol();
        string memory actualsymbol = nft.symbol();

        // Act & Assert
        if (bytes(expectedSymbol).length != bytes(actualsymbol).length) {
            revert NftTest__DiffrentCollection();
        }
        else {
            assertEq(keccak256(abi.encodePacked(expectedSymbol)), keccak256(abi.encodePacked(actualsymbol)));
        }
    }

    function test_verifyMintAndBalance() public {
        // Arrange
        vm.prank(i_user);
        nft.mintNft(NERO_URI);

        // Assert
        assertEq(nft.balanceOf(i_user), 1);
    }

    function test_verifyTokenURIIsCorrect() public {
        vm.prank(i_user);
        nft.mintNft(NERO_URI);

        assert(
            keccak256(abi.encodePacked(nft.tokenURI(0))) == keccak256(abi.encodePacked(NERO_URI))
        );
    }
}