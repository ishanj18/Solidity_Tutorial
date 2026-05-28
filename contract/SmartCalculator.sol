// Build a contract that uses another contract to do calculations. You'll learn how contracts can talk to each other by calling functions of other contracts (using `address casting`). It's like having one app ask another app to do some math, showing how to interact with other contracts.

// # Concepts You'll Master
// 1. Calling functions of another contract
// 2. address casting
// 3. imports

// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.20;

// First Contract
contract Calculator {
    function add(uint256 a, uint256 b) public pure returns (uint256) {
        return a + b;
    }

    function subtract(uint256 a, uint256 b) public pure returns (uint256) {
        return a - b;
    }

    function multiply(uint256 a, uint256 b) public pure returns (uint256) {
        return a * b;
    }

    function divide(uint256 a, uint256 b) public pure returns (uint256) {
        require(b > 0, "Cannot divide by zero");

        return a / b;
    }
}

// Second Contract
contract SmartCalculator {
    Calculator public calculator;

    constructor(address _calculatorAddress) {
        calculator = Calculator(_calculatorAddress);
    }

    function smartAdd(uint256 a, uint256 b) public view returns (uint256) {
        return calculator.add(a, b);
    }

    function smartSubtract(uint256 a, uint256 b) public view returns (uint256) {
        return calculator.subtract(a, b);
    }

    function smartMultiply(uint256 a, uint256 b) public view returns (uint256) {
        return calculator.multiply(a, b);
    }

    function smartDivide(uint256 a, uint256 b) public view returns (uint256) {
        return calculator.divide(a, b);
    }
}
