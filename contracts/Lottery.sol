pragma solidity ^0.4.0;

contract Lottery{
    //variable to store the manager address
    address public manager;     
    
    //we are storing the address of the participants onto array
    address[] public participants;
    
    constructor () public {
        manager = msg.sender; 
    }

    //Function to enter the lottery, we are going to make each users pay gas a small amount to enter the lottery
    function enterLottery() public payable{
        require(msg.value > 0.01 ether); 
        participants.push(msg.sender); 
    }
    
    function pickWinner() public{
        //check that only the manager can call the pick winner function
        require(msg.sender == manager);
        
        //select a random participants
        uint index = random() % participants.length;
        
        //transfer the contract balance to the participants
        participants[index].transfer(this.balance); //transfer the contract balance to the winner
        
        //empty the address array of participants
        participants = new address[](0); //means initial the array with 0.
    }
    
    function random() private view returns(uint256){
        return uint(keccak256(block.difficulty, now, participants)); //generate a random number
    }    
}