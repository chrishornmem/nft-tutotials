// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract IDZ is ERC1155, Ownable {
    uint256 public constant ASSET0 = 1;

    constructor()
        ERC1155(
            "https://bafybeigohx3ya3zy2qchhjwdmamrin2wx76phr5f5x66ryliz5g7654w5i.ipfs.nftstorage.link/metadata/${id}.json"
        )
    {
        _mint(msg.sender, ASSET0, 50000, "");
    }

    function mint(address account, uint256 id, uint256 amount) public onlyOwner {
        _mint(account, id, amount, "");
    }

        /** @dev URI override for OpenSea traits compatibility. */

    function uri(uint256 tokenId) override public pure returns (string memory) {
        // Tokens minted above the supply cap will not have associated metadata.
        require(tokenId >= 1 && tokenId < 50000, "ERC1155Metadata: URI query for nonexistent token");
        return string(abi.encodePacked("https://bafybeigohx3ya3zy2qchhjwdmamrin2wx76phr5f5x66ryliz5g7654w5i.ipfs.nftstorage.link/metadata/", Strings.toString(tokenId), ".json"));
    }
    /*
     * Override isApprovedForAll to auto-approve OS's proxy contract
     */
    function isApprovedForAll(address _owner, address _operator)
        public
        view
        override
        returns (bool isOperator)
    {
        // if OpenSea's ERC1155 Proxy Address is detected, auto-return true
        if (_operator == address(0x207Fa8Df3a17D96Ca7EA4f2893fcdCb78a304101)) {
            return true;
        }
        // otherwise, use the default ERC1155.isApprovedForAll()
        return ERC1155.isApprovedForAll(_owner, _operator);
    }
}
