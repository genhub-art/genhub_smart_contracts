// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Strings.sol";



contract Collection is ERC721 {
//    struct revelation { uint256 tid; string tmd;}
    struct TokenURLParts {string before_collection_address; string between_collection_address_and_token_id; string after_token_id;}
    uint256 public max_tid;
    uint256 public current_tid = 0;
    uint256 public price;
    uint256 public constant percent_fee = 2 ; 
    address payable public creator;
    address public constant fee_recipient = 0x391046DB4ffF37a258A5A0a8361EaF2F58DA309D;
    mapping(uint256 => string) public token_params;
    string public contract_metadata;
    TokenURLParts public token_url_parts = TokenURLParts("https://api.genhub.art/rpc/get_nft_metadata?chain=bsc_testnet&collection=", "&token_id=", "");
    
    constructor(address payable _creator, string memory _contract_metadata, uint256 max_quantity, uint256 _price) ERC721("","") {
        max_tid = max_quantity;
        price = _price;
        creator = _creator;
        contract_metadata = _contract_metadata;
    }

    function mint(string memory _token_params) public payable {
        require(current_tid<max_tid, "All tokens have been minted.");
        require(msg.value == price, "Insufficient Payment.");
        _mint(msg.sender, current_tid);
        token_params[current_tid] = _token_params;
        current_tid += 1;
        uint256 fee = msg.value * percent_fee / 100;
        (bool sent, ) = creator.call{value: msg.value - fee}("");
        require(sent, "Payment Failed.");
        (bool sent2, ) = fee_recipient.call{value: fee}("");
        require(sent2, "Payment Failed.");
        
    }
    function setPrice(uint256 new_price) public {
        require(msg.sender == creator, "No Permission.");
        price = new_price;
    }
    function burn(uint256 new_max_tid) public {
        require(msg.sender == creator, "No permission.");
        require(new_max_tid < max_tid && new_max_tid >= current_tid, "Invalid Burn Attempt.");
        max_tid = new_max_tid;
    }


    function getPrice() public view returns (uint256) { return price; }
    function getCreator() public view returns (address) {return creator;}
    function getCurrentTid() public view returns (uint256) { return current_tid; }
    function getMaxTid() public view returns (uint256) { return max_tid; }

    function contractURI() public view returns (string memory) { return contract_metadata;}


    function getTokenParams(uint256 _tokenid) public view returns (string memory) { return token_params[_tokenid];}
    function uri(uint256 _tokenid) public view returns (string memory) {
        return string.concat(token_url_parts.before_collection_address, Strings.toHexString(uint160(address(this))), token_url_parts.between_collection_address_and_token_id, Strings.toString(_tokenid), token_url_parts.after_token_id);
    }
    function tokenURI(uint256 _tokenid) override public view returns (string memory) {
        return string.concat(token_url_parts.before_collection_address, Strings.toHexString(uint160(address(this))), token_url_parts.between_collection_address_and_token_id, Strings.toString(_tokenid), token_url_parts.after_token_id);
    }
}