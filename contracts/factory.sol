// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./collection.sol";



contract CollectionFactory {
    Collection[] public cols;
    function deploy(string memory contract_metadata, uint256 max_quantity, uint256 price_) public payable {
        cols.push(new Collection(payable(msg.sender),contract_metadata, max_quantity, price_));
    }
    function getAllCollections() public view returns (Collection[] memory){ return cols; }
    // function mintProxy(uint256 i) public payable {
    //     cols[i].mint{value:msg.value}();
    // }
}