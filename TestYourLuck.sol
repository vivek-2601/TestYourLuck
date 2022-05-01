pragma solidity ^0.8.7;
// SPDX-License-Identifier: UNLICENSED

contract coinFlip{

    // The vrf function from Harmony
    // https://docs.harmony.one/home/developers/tools/harmony-vrf#how-to-access-harmony-vrf-within-smart-contract
    function vrf() public view returns (bytes32 result) {
        uint[1] memory bn;
        bn[0] = block.number;
        assembly {
        let memPtr := mload(0x20)
        if iszero(staticcall(not(0), 0x10, bn, 0x20, memPtr, 0x20)) {
            invalid()
        }
        result := mload(memPtr)
        }
    }

    enum State {Head, Tail}

    // represents a player
    struct Player {
        uint256 amount;  // amount he has      
        uint256 betAmt;        
        State betOn;           
    }
    
    mapping(address => Player) players;      // mapping from address to Player
    
    // return remaining amount of a player
    function remAmount() public view returns(uint256){
        return players[msg.sender].amount;
    }

    // return the current bet amount 
    function betAmt() public view returns(uint256){
        return players[msg.sender].betAmt;
    }

    // returns 0 for bet on Head, 1 for Tail
    function betOn() public view returns(State){
        return players[msg.sender].betOn;
    }

    
    // adds new player or
    // reset already existing player
    function addPlayer() public{
        players[msg.sender] = Player(100, 0, State.Head);
    }

    // allows a player to place bet
    function placeBet(uint256 amount, State betOn)public returns(bool){
        Player memory p = players[msg.sender];
        
        // check for sufficient balance
        if(p.amount == 0 || amount > p.amount )return false;

        // ensure only one bet at a time.
        if(p.betAmt > 0)return false;

        // we are not concerned about bet with betAmt == 0
        // it is same as placing no bet

        p.amount -= amount;
        p.betAmt = amount;
        p.betOn = betOn;

        // update the corresponding player in mapping
        players[msg.sender] = p;

        return true;
    }

    // gets triggered when a player wins
    event win(address sender, uint256 amount);

    // vrf is not working as it should
    // it was working fine earlier
    // help will be apriciated 
    uint public rand_v;
    function set_rand()public{
        rand_v = uint(vrf());
    }

    // allow a player to make draw
    function drawBet() public{
        Player memory p = players[msg.sender];
        require(p.betAmt > 0);
        State draw = State.Tail;
        rand_v = uint(vrf());
        if(rand_v % 2 == 0 )draw = State.Head;
        if(draw == p.betOn){
            p.amount +=  2*p.betAmt;
            emit win(msg.sender, p.betAmt);
        }
        // set betAmt to 0 after a draw
        p.betAmt = 0;

        // update the corresponding player in mapping
        players[msg.sender] = p;
    }     
}
