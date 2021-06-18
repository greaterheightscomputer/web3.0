pragma solidity >= 0.4.12 < 0.9.0;

contract Lottery{
    //variable to store manager public address
    address public manager;

    //we are storing the public address of the participants in an array
    address[] public participants;
    
    constructor() public{
        manager = msg.sender; //msg.sender is predefined global variable that store address of person who is deploy this contract
    }

    //Function to enter the lottery, we are going to make each user pay a small amount to enter the lottery
    function enterLottery() public payable{ //payable means any person that call this function will pay gas fee
        require(msg.value > 0.01 ether); //msg.value implicitly store the value of the sender
        participants.push(msg.sender); //storing the participants public address on the array
    }

    function pickWinner() public{
        //check only that the manager can call the pick winner function
        require(msg.sender == manager);

        //select a random participant
        uint index = random() % participants.length; //2343432432432532 % 3

        //transfer the contract balance to the participants
        // participants[index].transfer(this.balance);
        payable(participants[index]).transfer(address (this).balance);

        //empty the address array
        participants = new address[](0);
    }

    //generate a random numbers
    function random() private view returns(uint256){
        return uint(keccak256(abi.encodePacked(block.difficulty, participants)));
        // return uint(keccak256(block.difficulty, now, participants));
    }
}
