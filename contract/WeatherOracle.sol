// Build a smart contract that retrieves live weather data using an oracle like Chainlink. You'll create a decentralized crop insurance contract where farmers can claim insurance if rainfall drops below a certain threshold during the growing season. Since the Ethereum blockchain can't access real-world data on its own, you'll use an oracle to fetch off-chain weather information and trigger payouts automatically. This project demonstrates how to securely integrate external data into your contract logic and highlights the power of real-world connectivity in smart contracts.

// # Concepts you will master
// 1. Interacting with oracles
// 2. fetching off-chain data

// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.20;

contract WeatherOracle {
    address public farmer;
    address public oracle;
    uint public rainfall;
    uint public minimumRainfall;
    bool public claimed;

    constructor(uint _minimumRainfall) payable {
        farmer = msg.sender;
        oracle = msg.sender;
        minimumRainfall = _minimumRainfall;
    }

    function updateRainfall(uint _rainfall) public {
        require(msg.sender == oracle, "Only oracle can update");
        rainfall = _rainfall;
    }

    function claimInsurance() public {
        require(msg.sender == farmer, "Only farmer can claim");
        require(!claimed, "Already claimed");
        require(rainfall < minimumRainfall, "Rainfall threshold not reached");

        claimed = true;

        uint amount = address(this).balance;

        (bool success, ) = payable(farmer).call{value: amount}("");

        require(success, "Transfer failed");
    }

    function getContractBalance() public view returns (uint) {
        return address(this).balance;
    }
}
