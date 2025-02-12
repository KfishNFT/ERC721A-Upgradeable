// SPDX-License-Identifier: MIT
// ERC721A Contracts v4.1.0
// Creator: Chiru Labs

pragma solidity ^0.8.4;

import '../IERC721AUUPSUpgradeable.sol';

/**
 * @dev Interface of an ERC721ABurnable compliant contract.
 */
interface IERC721ABurnableUUPSUpgradeable is IERC721AUUPSUpgradeable {
    /**
     * @dev Burns `tokenId`. See {ERC721A-_burn}.
     *
     * Requirements:
     *
     * - The caller must own `tokenId` or be an approved operator.
     */
    function burn(uint256 tokenId) external;
}
