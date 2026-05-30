// Build a simple voting system where users can vote on proposals. Your challenge is to make it as gas-efficient as possible. Optimize how you store voter data, handle input parameters, and design functions. You'll learn how `calldata`, `memory`, and `storage` affect gas usage and discover small changes that lead to big savings. It's like designing a voting machine that runs faster and cheaper without losing accuracy.

// # Concepts you will master
// 1. Gas optimization
// 2. Efficient data locations
// 3. Calldata vs memory
// 4. Minimizing storage writes

// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.20;

contract GasSaver {
    struct Proposal {
        string name;
        uint256 voteCount;
    }

    Proposal[] public proposals;

    mapping(address => bool) public hasVoted;

    function addProposal(string calldata _name) public {
        proposals.push(Proposal({name: _name, voteCount: 0}));
    }

    function vote(uint256 _proposalId) public {
        require(!hasVoted[msg.sender], "Already voted");

        require(_proposalId < proposals.length, "Invalid proposal");

        Proposal storage proposal = proposals[_proposalId];

        proposal.voteCount += 1;

        hasVoted[msg.sender] = true;
    }

    function getProposal(
        uint256 _proposalId
    ) public view returns (string memory, uint256) {
        Proposal storage proposal = proposals[_proposalId];

        return (proposal.name, proposal.voteCount);
    }

    function totalProposals() public view returns (uint256) {
        return proposals.length;
    }
}
