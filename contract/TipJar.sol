// Build a multi-currency digital tip jar! Users can send Ether directly or simulate tips in foreign currencies like USD or EUR. You'll learn how to manage currency conversion, handle Ether payments using `payable` and `msg.value`, and keep track of individual contributions. Think of it like an advanced version of a 'Buy Me a Coffee' button — but smarter, more global, and Solidity-powered.

// # Concepts You'll Master
// 1. conversion
// 2. denominations
// 3. payable

// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.20;

contract TipJar {
    address public owner;
    uint256 public totalEthTips;

    // Conversion rates
    uint256 public usdToEth;
    uint256 public eurToEth;

    mapping(address => uint256) public contributions;

    constructor(uint256 _usdRate, uint256 _eurRate) {
        owner = msg.sender;

        usdToEth = _usdRate;
        eurToEth = _eurRate;
    }

    function tipETH() public payable {
        require(msg.value > 0, "Send some ETH");

        contributions[msg.sender] += msg.value;

        totalEthTips += msg.value;
    }

    function tipUSD(uint256 usdAmount) public payable {
        require(usdAmount > 0, "Amount must be greater than 0");

        uint256 ethAmount = usdAmount * usdToEth;

        require(msg.value == ethAmount, "Incorrect ETH sent");

        contributions[msg.sender] += msg.value;

        totalEthTips += msg.value;
    }

    function tipEUR(uint256 eurAmount) public payable {
        require(eurAmount > 0, "Amount must be greater than 0");

        uint256 ethAmount = eurAmount * eurToEth;

        require(msg.value == ethAmount, "Incorrect ETH sent");

        contributions[msg.sender] += msg.value;

        totalEthTips += msg.value;
    }

    function withdrawTips() public {
        require(msg.sender == owner, "Only owner can withdraw");

        uint256 balance = address(this).balance;

        require(balance > 0, "No ETH available");

        (bool success, ) = payable(owner).call{value: balance}("");

        require(success, "Transfer failed");
    }

    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
