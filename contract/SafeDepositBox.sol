// Build a smart bank that offers different types of deposit boxes — basic, premium, time-locked, etc. Each box follows a common interface and supports ownership transfer. A central VaultManager contract interacts with all deposit boxes in a unified way, letting users store secrets and transfer ownership like handing over the key to a digital locker. This teaches interface design, modularity, and how contracts communicate with each other safely.

// # Concepts you will master
// 1. Interfaces
// 2. Abstraction
// 3. Ownership Transfer
// 4. Contract-to-contract interaction

// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.20;

interface IDepositBox {
    function storeSecret(string memory _secret) external;

    function getSecret() external view returns (string memory);

    function transferOwnership(address newOwner) external;
}

// BASIC DEPOSIT BOX
contract BasicDepositBox is IDepositBox {
    address public owner;
    string private secret;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner allowed");

        _;
    }

    function storeSecret(string memory _secret) public override onlyOwner {
        secret = _secret;
    }

    function getSecret() public view override returns (string memory) {
        return secret;
    }

    function transferOwnership(address newOwner) public override onlyOwner {
        require(newOwner != address(0), "Invalid address");

        owner = newOwner;
    }
}

// VAULT MANAGER CONTRACT
contract VaultManager {
    IDepositBox public box;

    constructor(address boxAddress) {
        // Address casting
        box = IDepositBox(boxAddress);
    }

    function storeUsingManager(string memory _secret) public {
        box.storeSecret(_secret);
    }

    function readSecret() public view returns (string memory) {
        return box.getSecret();
    }

    function changeBoxOwner(address newOwner) public {
        box.transferOwnership(newOwner);
    }
}
