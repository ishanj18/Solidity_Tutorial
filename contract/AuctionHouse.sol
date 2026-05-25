// Create a basic auction! Users can bid on an item, and the highest bidder wins when time runs out. You'll use 'if/else' to decide who wins based on the highest bid and track time using the blockchain's clock (`block.timestamp`). This is like a simple version of eBay on the blockchain, showing how to control logic based on conditions and time.

// # Concepts You'll Master
// 1. if/else statements
// 2. Time (block.timestamp)
// 3. Basic bidding

// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;

contract BasicAuction {
    address public highestBidder;
    uint public highestBid;
    uint public auctionEndTime;
    bool public auctionEnded;

    constructor(uint _biddingTime) {
        auctionEndTime = block.timestamp + _biddingTime;
    }

    function bid() public payable {
        require(block.timestamp < auctionEndTime, "Auction has ended");
        require(
            msg.value > highestBid,
            "Bid must be higher than current highest bid"
        );

        highestBidder = msg.sender;
        highestBid = msg.value;
    }

    function endAuction() public {
        require(block.timestamp >= auctionEndTime, "Auction is still running");
        require(!auctionEnded, "Auction already ended");

        auctionEnded = true;
    }

    function getWinner() public view returns (address, uint) {
        require(auctionEnded, "Auction has not ended yet");
        return (highestBidder, highestBid);
    }
}
