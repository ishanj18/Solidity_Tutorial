// Build a contract that simulates a treasure chest controlled by an owner. The owner can add treasure, approve withdrawals for specific users, and even withdraw treasure themselves. Other users can attempt to withdraw, but only if the owner has given them an allowance and they haven't withdrawn before. The owner can also reset withdrawal statuses and transfer ownership of the treasure chest. This demonstrates how to create a contract with restricted access using a 'modifier' and `msg.sender`, similar to how only an admin can perform certain actions in a game or application.

// # Concepts You'll Master
// 1. modifier
// 2. msg.sender for ownership
// 3. Basic access control

// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.20;

contract TreasureChest {
    address public owner;

    constructor() {
        owner = msg.sender; // Set the contract deployer as the owner
    }

    modifier onlyOwner() {
        require(
            msg.sender == owner,
            "Access denied: Only the owner can perform this action"
        );
        _;
    }

    uint public treasureAmount;

    function addTreasure(uint amount) public onlyOwner {
        treasureAmount += amount;
    }

    mapping(address => uint) public withdrawalAllowance;

    function approveWithdrawal(
        address recipient,
        uint amount
    ) public onlyOwner {
        require(amount <= treasureAmount, "Not enough treasure available");
        withdrawalAllowance[recipient] = amount;
    }

    mapping(address => bool) public hasWithdrawn;

    function withdrawTreasure(uint amount) public {
        if (msg.sender == owner) {
            require(
                amount <= treasureAmount,
                "Not enough treasury available for this action."
            );
            treasureAmount -= amount;
            return;
        }
        uint allowance = withdrawalAllowance[msg.sender];
        require(allowance > 0, "You don't have any treasure allowance");
        require(
            !hasWithdrawn[msg.sender],
            "You have already withdrawn your treasure"
        );
        require(
            allowance <= treasureAmount,
            "Not enough treasure in the chest"
        );

        hasWithdrawn[msg.sender] = true;
        treasureAmount -= allowance;
        withdrawalAllowance[msg.sender] = 0;
    }

    function resetWithdrawalStatus(address user) public onlyOwner {
        hasWithdrawn[user] = false;
    }

    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "Invalid address");
        owner = newOwner;
    }

    function getTreasureDetails() public view onlyOwner returns (uint) {
        return treasureAmount;
    }
}
