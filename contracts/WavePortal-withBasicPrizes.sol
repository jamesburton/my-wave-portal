// // SPDX-License-Identifier: UNLICENSED

// pragma solidity ^0.8.0;

// import "hardhat/console.sol";

// // Updated to include messages (see https://buildspace.so/p/build-solidity-web3-app/lessons/storing-messages-from-users-on-blockchain)

// contract WavePortal {
//     uint256 totalWaves;

//     /*
//      * A little magic, Google what events are in Solidity!
//      */
//     event NewWave(address indexed from, uint256 timestamp, string message);

//     /*
//      * I created a struct here named Wave.
//      * A struct is basically a custom datatype where we can customize what we want to hold inside it.
//      */
//     struct Wave {
//         address waver; // The address of the user who waved.
//         string message; // The message the user sent.
//         uint256 timestamp; // The timestamp when the user waved.
//     }

//     /*
//      * I declare a variable waves that lets me store an array of structs.
//      * This is what lets me hold all the waves anyone ever sends to me!
//      */
//     Wave[] waves;

//     // constructor() {
//     // NB: We needed to add "payable" to enable contract to hold and send funds 
//     constructor() payable {
//         console.log("The start of a SmartContract for sharing Waves");
//     }

//     /*
//      * You'll notice I changed the wave function a little here as well and
//      * now it requires a string called _message. This is the message our user
//      * sends us from the frontend!
//      */
//     function wave(string memory _message) public {
//         totalWaves += 1;
//         console.log("%s waved w/ message %s", msg.sender, _message);

//         /*
//          * This is where I actually store the wave data in the array.
//          */
//         waves.push(Wave(msg.sender, _message, block.timestamp));

//         /*
//          * I added some fanciness here, Google it and try to figure out what it is!
//          * Let me know what you learn in #general-chill-chat
//          */
//         emit NewWave(msg.sender, block.timestamp, _message);

//         // Add prize (see https://buildspace.so/p/build-solidity-web3-app/lessons/fund-contract-send-prize-ethereum-users)
//         //uint256 prizeAmount = 0.0001 ether;
//         uint256 prizeAmount = 0.00001 ether;
//         require(
//             prizeAmount <= address(this).balance,
//             "Trying to withdraw more money than the contract has."
//         );
//         (bool success, ) = (msg.sender).call{value: prizeAmount}("");
//         require(success, "Failed to withdraw money from contract.");
//     }

//     /*
//      * I added a function getAllWaves which will return the struct array, waves, to us.
//      * This will make it easy to retrieve the waves from our website!
//      */
//     function getAllWaves() public view returns (Wave[] memory) {
//         return waves;
//     }

//     function getTotalWaves() public view returns (uint256) {
//         // Optional: Add this line if you want to see the contract print the value!
//         // We'll also print it over in run.js as well.
//         console.log("We have %d total waves!", totalWaves);
//         return totalWaves;
//     }
// }