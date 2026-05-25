// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.20;

contract Poll{
     
string[] public candidateNames;
mapping(string => uint) voteCount;

function addCandidateNames(string memory _candidateNames) public {
    candidateNames.push(_candidateNames);
    voteCount[_candidateNames] = 0;
}
 
function getcandidateNames() public view returns (string[] memory) {
    return candidateNames;
}

function vote(string memory _candidateNames) public {
    voteCount[_candidateNames]++;
}

function getVote(string memory _candidateNames) public view returns (uint256) {
    return voteCount[_candidateNames];
}

}