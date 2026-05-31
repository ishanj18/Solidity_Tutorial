// Build a secure signature-based entry system for a private Web3 event, like a conference, workshop, or token-gated meetup. Instead of storing an on-chain whitelist of attendees, your backend or event organizer signs a message for each approved guest. When attendees arrive, they submit their signed message to the smart contract to prove they were invited. The contract uses `ecrecover` to verify the signature on-chain, confirming their identity without needing any prior on-chain registration. This pattern drastically reduces gas costs, keeps the contract lightweight, and mirrors how many real-world events handle off-chain approvals with on-chain validation — a practical Web3 authentication flow.

// # Concepts you will master
// 1. ecrecover
// 2. verifying signatures
// 3. basic authentication

// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.20;

contract SignThis {
    address public organizer;

    mapping(address => bool) public entered;

    constructor() {
        organizer = msg.sender;
    }

    function verifyAndEnter(
        bytes32 messageHash,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) public {
        require(!entered[msg.sender], "Already entered");

        address signer = ecrecover(messageHash, v, r, s);
        require(signer == organizer, "Invalid invitation");

        entered[msg.sender] = true;
    }
}
