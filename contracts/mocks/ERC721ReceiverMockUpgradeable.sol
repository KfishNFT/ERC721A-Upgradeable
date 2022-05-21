// SPDX-License-Identifier: MIT
// ERC721A Contracts v3.3.0
// Creators: Chiru Labs

pragma solidity ^0.8.4;

import "../ERC721AUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

interface IERC721AMockUpgradeable {
    function safeMint(address to, uint256 quantity) external;
}

contract ERC721ReceiverMockUpgradeable is Initializable, ERC721A__IERC721ReceiverUpgradeable {
    enum Error {
        None,
        RevertWithMessage,
        RevertWithoutMessage,
        Panic
    }

    bytes4 private _retval;
    address private _erc721aMock;

    event Received(address operator, address from, uint256 tokenId, bytes data, uint256 gas);

    function __ERC721ReceiverMock_init(bytes4 retval, address erc721aMock) internal onlyInitializing {
        __ERC721ReceiverMock_init_unchained(retval, erc721aMock);
    }

    function __ERC721ReceiverMock_init_unchained(bytes4 retval, address erc721aMock) internal onlyInitializing {
        _retval = retval;
        _erc721aMock = erc721aMock;
    }

    function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes memory data
    ) public override returns (bytes4) {
        // for testing reverts with a message from the receiver contract
        if (bytes1(data) == 0x01) {
            revert('reverted in the receiver contract!');
        }

        // for testing with the returned wrong value from the receiver contract
        if (bytes1(data) == 0x02) {
            return 0x0;
        }

        // for testing the reentrancy protection
        if (bytes1(data) == 0x03) {
            IERC721AMockUpgradeable(_erc721aMock).safeMint(address(this), 1);
        }

        emit Received(operator, from, tokenId, data, 20000);
        return _retval;
    }

    /**
     * @dev This empty reserved space is put in place to allow future versions to add new
     * variables without shifting down storage in the inheritance chain.
     * See https://docs.openzeppelin.com/contracts/4.x/upgradeable#storage_gaps
     */
    uint256[49] private __gap;
}
