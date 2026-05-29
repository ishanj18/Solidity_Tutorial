// Let's make your own digital currency! You'll create a basic token that can be transferred between users, implementing the ERC20 standard. It's like creating your own in-game money, demonstrating how to create and manage tokens.

// # Concepts you will master
// 1. ERC20 interface
// 2. totalSupply
// 3. balanceOf
// 4. transfer
// 5. token basics

// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.20;

contract MyFirstToken {
    string public name = "MyFirstToken";
    string public symbol = "MFT";
    uint256 public totalSupply;

    mapping(address => uint256) public balances;

    event Transfer(address indexed from, address indexed to, uint256 amount);

    constructor(uint256 _initialSupply) {
        totalSupply = _initialSupply;

        balances[msg.sender] = totalSupply;
    }

    function balanceOf(address user) public view returns (uint256) {
        return balances[user];
    }

    function transfer(address to, uint256 amount) public returns (bool) {
        require(balances[msg.sender] >= amount, "Not enough tokens");

        require(to != address(0), "Invalid address");

        balances[msg.sender] -= amount;
        balances[to] += amount;
        emit Transfer(msg.sender, to, amount);

        return true;
    }
}
