// Build a secure Vault contract that only the owner (master key holder) can control. You'll split your logic into two parts: a reusable 'Ownable' base contract and a 'VaultMaster' contract that inherits from it. Only the owner can withdraw funds or transfer ownership. This shows how to use Solidity's inheritance model to write clean, reusable access control patterns — just like in real-world production contracts. It's like building a secure digital safe where only the master key holder can access or delegate control.

// # Concepts you will master
// 1. Ownable pattern
// 2. inheritance
// 3. robust access control

// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.20;

contract Ownable {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");

        _;
    }

    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "Invalid address");

        owner = newOwner;
    }
}

// Main Vault Contract
// Inherits Ownable contract
contract VaultMaster is Ownable {
    event Deposit(address indexed user, uint256 amount);

    event Withdrawal(address indexed owner, uint256 amount);

    function deposit() public payable {
        require(msg.value > 0, "Send some ETH");
        emit Deposit(msg.sender, msg.value);
    }

    function withdraw(uint256 amount) public onlyOwner {
        require(amount <= address(this).balance, "Insufficient vault balance");

        (bool success, ) = payable(owner).call{value: amount}("");

        require(success, "Transfer failed");

        emit Withdrawal(owner, amount);
    }

    function getVaultBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
