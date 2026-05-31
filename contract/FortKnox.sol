//  Build a secure digital vault where users can deposit and withdraw tokenized gold (or any valuable asset), ensuring it's protected from reentrancy attacks. Imagine you're creating a decentralized version of Fort Knox — users lock up tokenized gold, and can later withdraw it. But just like a real vault, this contract must prevent attackers from repeatedly triggering the withdrawal logic before the balance updates. You'll implement the `nonReentrant` modifier to block reentry attempts, and follow Solidity security best practices to lock down your contract. This project shows how a seemingly simple withdrawal function can become a vulnerability — and how to defend it properly.

// # Concepts you will master
// 1. Reentrancy attacks
// 2. nonReentrant modifier
// 3. security best practices

// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.20;

contract FortKnox {
    mapping(address => uint256) public balances;

    bool private locked;

    modifier nonReentrant() {
        require(!locked, "Reentrant call detected");

        locked = true;

        _;

        locked = false;
    }

    function deposit() public payable {
        require(msg.value > 0, "Send some ETH");

        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) public nonReentrant {
        require(balances[msg.sender] >= amount, "Insufficient balance");

        balances[msg.sender] -= amount;

        (bool success, ) = payable(msg.sender).call{value: amount}("");

        require(success, "Transfer failed");
    }

    function checkBalance() public view returns (uint256) {
        return balances[msg.sender];
    }
}
