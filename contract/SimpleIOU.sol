// Build a simple IOU contract for a private group of friends. Each user can deposit ETH, track personal balances, log who owes who, and settle debts — all on-chain. You’ll learn how to accept real Ether using `payable`, transfer funds between addresses, and use nested mappings to represent relationships like 'Alice owes Bob'. This contract mirrors real-world borrowing and lending, and teaches you how to model those interactions in Solidity.

// # Concepts You'll Master
// 1. address
// 2. token transfer
// 3. payable for gas
// 4. validation (require)

// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.20;

contract SimpleIOU {
    // Stores ETH balance of each user
    mapping(address => uint256) public balances;

    // Stores debts:
    // debts[debtor][creditor] = amount
    mapping(address => mapping(address => uint256)) public debts;

    // Deposit ETH into contract
    function deposit() public payable {
        require(msg.value > 0, "Send some ETH");

        balances[msg.sender] += msg.value;
    }

    // Record a debt
    function recordDebt(address creditor, uint256 amount) public {
        require(creditor != address(0), "Invalid address");
        require(creditor != msg.sender, "Cannot owe yourself");
        require(amount > 0, "Amount must be greater than 0");

        debts[msg.sender][creditor] += amount;
    }

    // Pay debt using deposited balance
    function payDebt(address creditor, uint256 amount) public {
        require(amount > 0, "Amount must be greater than 0");
        require(debts[msg.sender][creditor] >= amount, "Debt amount too high");
        require(balances[msg.sender] >= amount, "Insufficient balance");

        balances[msg.sender] -= amount;
        balances[creditor] += amount;

        debts[msg.sender][creditor] -= amount;
    }

    // Withdraw ETH from contract
    function withdraw(uint256 amount) public {
        require(amount > 0, "Amount must be greater than 0");
        require(balances[msg.sender] >= amount, "Insufficient balance");

        balances[msg.sender] -= amount;

        (bool success, ) = payable(msg.sender).call{value: amount}("");
        require(success, "Withdrawal failed");
    }

    // Check your balance
    function checkBalance() public view returns (uint256) {
        return balances[msg.sender];
    }

    // Check debt between users
    function checkDebt(address creditor) public view returns (uint256) {
        return debts[msg.sender][creditor];
    }
}
