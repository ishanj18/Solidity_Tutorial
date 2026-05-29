// Build a contract to sell your tokens for Ether. You'll learn how to set a price and manage sales, demonstrating token economics. It's like a pre-sale for your digital currency, showing how to sell tokens for Ether.

// # Concepts you will master
// 1. Selling tokens for Ether
// 2. rate calculations
// 3. token economics

// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.20;

contract SellToken {
    uint256 public tokenPrice = 0.01 ether;
    uint256 public availableTokens;

    address public owner;
    mapping(address => uint256) public balances;

    constructor(uint256 _tokens) {
        availableTokens = _tokens;
        owner = msg.sender;
    }

    function buyTokens() public payable {
        require(msg.value > 0, "Send ETH to buy tokens");

        uint256 tokensToSend = msg.value / tokenPrice;

        require(tokensToSend <= availableTokens, "Not enough tokens available");
        availableTokens -= tokensToSend;
        balances[msg.sender] += tokensToSend;
    }

    function withdrawETH() public {
        require(msg.sender == owner, "Only owner can withdraw");

        (bool success, ) = payable(owner).call{value: address(this).balance}(
            ""
        );

        require(success, "Transfer failed");
    }
}
