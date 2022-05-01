pragma solidity ^0.8.7;
// SPDX-License-Identifier: UNLICENSED


contract coinFlip{
    address owner;
    uint256 public totPlayers = 0;
    bytes32 public rand_no;
    mapping(address => Player) players;
    constructor(){
        owner = msg.sender;
    }   
    function myVRF() public{
        rand_no = vrf();
        
    }
    function vrf() public view returns (bytes32 result) {
        uint[1] memory bn;
        bn[0] = block.number;
        assembly {
        let memPtr := mload(0x40)
        if iszero(staticcall(not(0), 0xff, bn, 0x20, memPtr, 0x20)) {
            invalid()
        }
        result := mload(memPtr)
        }
    }
    function addPlayer() public{
        // do not increament count if player already existed
        if(players[msg.sender].amount == 0)totPlayers += 1;
        players[msg.sender] = Player(100, 0, false);
    }
    struct Player{
        uint256 amount;
        uint256 betAmt;
        bool betOn;

    }
    function placeBet(uint256 amount, bool betOn)public{
        Player memory p = players[msg.sender];
        require(p.amount > amount);
        require(p.betAmt == 0);
        p.amount -= amount;
        p.betAmt = amount;
        p.betOn = betOn;
    }

    function rewardBet() public{
        Player memory p = players[msg.sender];
        require(p.betAmt > 0);
        bool draw = false;
        if(uint256(vrf()) % 2 == 1 )draw = true;
        if(draw == p.betOn) p.amount +=  2*p.betAmt;
        p.betAmt = 0;
    }
        
}

