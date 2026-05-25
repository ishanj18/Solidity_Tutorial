// Let's make a digital piggy bank! Users can deposit and withdraw Ether (the cryptocurrency). You'll learn how to manage balances (using `address` to identify users) and track who sent Ether (using `msg.sender`). It's like a simple bank account on the blockchain, demonstrating how to handle Ether and user addresses.

// # Concepts You'll Master
// 1. msg.sender
// 2. address
// 3. Ether balance
// 4. Deposits and withdrawals

// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.20;

contract EtherPiggyBank {
    mapping(address => uint256) public balances;

    // Deposit Ether into the contract
    function deposit() public payable {
        require(msg.value > 0, "You must send some Ether");
        balances[msg.sender] += msg.value;
    }

    // Withdraw Ether from the contract
    function withdraw(uint256 amount) public {
        require(amount > 0, "Amount must be greater than zero");
        require(balances[msg.sender] >= amount, "Insufficient balance");

        balances[msg.sender] -= amount;
        (bool success, ) = payable(msg.sender).call{value: amount}("");
        require(success, "Ether transfer failed");
    }

    // Check total Ether stored in the contract
    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }

    // Check your deposited balance
    function getMyBalance() public view returns (uint256) {
        return balances[msg.sender];
    }
}
