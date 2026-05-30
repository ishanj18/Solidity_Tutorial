// Build an upgradeable subscription manager for a SaaS-like dApp. The proxy contract stores user subscription info (like plans, renewals, and expiry dates), while the logic for managing subscriptions—adding plans, upgrading users, pausing accounts—lives in an external logic contract. When it's time to add new features or fix bugs, you simply deploy a new logic contract and point the proxy to it using `delegatecall`, without migrating any data. This simulates how real-world apps push updates without asking users to reinstall. You'll learn how to architect upgrade-safe contracts using the proxy pattern and `delegatecall`, separating storage from logic for long-term maintainability.

// # Concepts you will master
// 1. Upgradeable contracts
// 2. proxy pattern
// 3. delegate call for upgrades

// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.20;

// LOGIC CONTRACT
contract SubscriptionLogic {
    address public owner;
    address public implementation;

    mapping(address => string) public plans;
    mapping(address => bool) public active;

    function subscribe(string memory _plan) public {
        plans[msg.sender] = _plan;

        active[msg.sender] = true;
    }

    function upgradePlan(string memory _newPlan) public {
        require(active[msg.sender], "Not subscribed");

        plans[msg.sender] = _newPlan;
    }
}

// PROXY CONTRACT
contract UpgradeHub {
    address public owner;

    address public implementation;

    mapping(address => string) public plans;

    mapping(address => bool) public active;

    constructor(address _implementation) {
        owner = msg.sender;

        implementation = _implementation;
    }

    function upgradeLogic(address _newImplementation) public {
        require(msg.sender == owner, "Only owner");

        implementation = _newImplementation;
    }

    function executeSubscribe(string memory _plan) public {
        (bool success, ) = implementation.delegatecall(
            abi.encodeWithSignature("subscribe(string)", _plan)
        );

        require(success, "Subscribe failed");
    }

    function executeUpgradePlan(string memory _newPlan) public {
        (bool success, ) = implementation.delegatecall(
            abi.encodeWithSignature("upgradePlan(string)", _newPlan)
        );

        require(success, "Upgrade failed");
    }
}
