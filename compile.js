const path = require('path');
const fs = require('fs');
const solc = require('solc');

const LotteryPath = path.resolve(__dirname,'contracts','Lottery.sol'); //get the path where we have contracts/Lottery.sol
const source = fs.readFileSync(LotteryPath, 'utf8'); //get the code inside Lottery.sol
console.log(solc.compile(source,1));
