// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

// Updated to include messages (see https://buildspace.so/p/build-solidity-web3-app/lessons/storing-messages-from-users-on-blockchain)

contract WavePortal {
    uint256 totalWaves;

    /*
     * We will be using this below to help generate a random number
     */
    uint256 private seed;

    /*
     * A little magic, Google what events are in Solidity!
     */
    event NewWave(address indexed from, uint256 timestamp, string message);

    /*
     * I created a struct here named Wave.
     * A struct is basically a custom datatype where we can customize what we want to hold inside it.
     */
    struct Wave {
        address waver; // The address of the user who waved.
        string message; // The message the user sent.
        uint256 timestamp; // The timestamp when the user waved.
    }

    /*
     * I declare a variable waves that lets me store an array of structs.
     * This is what lets me hold all the waves anyone ever sends to me!
     */
    //Wave[] waves;
    mapping(uint256 => Wave) public waves;

    /*
     * This is an address => uint mapping, meaning I can associate an address with a number!
     * In this case, I'll be storing the address with the last time the user waved at us.
     */
    mapping(address => uint256) public lastWavedAt;

    // NB: We needed to add "payable" to enable contract to hold and send funds 
    constructor() payable {
        console.log("The start of a SmartContract for sharing Waves");
        /*
         * Set the initial seed
         */
        seed = (block.timestamp + block.difficulty) % 100;
    }

    function wave(string memory _message) public {
        // Check last waved and block if too recent:-
        /*
         * We need to make sure the current timestamp is at least 15-minutes bigger than the last timestamp we stored
         */
        require(
            lastWavedAt[msg.sender] + 15 minutes < block.timestamp,
            "Wait 15m"
        );
        // require(
        //     lastWavedAt[msg.sender] + 15 seconds < block.timestamp,
        //     "Wait 15s"
        // );

        /*
         * Update the current timestamp we have for the user
         */
        lastWavedAt[msg.sender] = block.timestamp;

        totalWaves += 1;
        console.log("%s waved w/ message %s", msg.sender, _message);

        //waves.push(Wave(msg.sender, _message, block.timestamp));
        waves[totalWaves - 1] = Wave(msg.sender, _message, block.timestamp);
        
        /*
         * Generate a new seed for the next user that sends a wave
         */
        seed = (block.difficulty + block.timestamp + seed) % 100;

        console.log("Random # generated: %d", seed);

        /*
         * Give a 25% chance that the user wins the prize.
         */
        if (seed < 25) {
            console.log("%s won!", msg.sender);

            /*
             * The same code we had before to send the prize.
             */
            uint256 prizeAmount = 0.0001 ether;
            // uint256 prizeAmount = 0.00001 ether;
            require(
                prizeAmount <= address(this).balance,
                "Trying to withdraw more money than the contract has."
            );
            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Failed to withdraw money from contract.");
        }

        /*
         * I added some fanciness here, Google it and try to figure out what it is!
         * Let me know what you learn in #general-chill-chat
         */
        emit NewWave(msg.sender, block.timestamp, _message);

        // Moved to random block above
        // // Add prize (see https://buildspace.so/p/build-solidity-web3-app/lessons/fund-contract-send-prize-ethereum-users)
        // //uint256 prizeAmount = 0.0001 ether;
        // uint256 prizeAmount = 0.00001 ether;
        // require(
        //     prizeAmount <= address(this).balance,
        //     "Trying to withdraw more money than the contract has."
        // );
        // (bool success, ) = (msg.sender).call{value: prizeAmount}("");
        // require(success, "Failed to withdraw money from contract.");
    }

    /*
     * I added a function getAllWaves which will return the struct array, waves, to us.
     * This will make it easy to retrieve the waves from our website!
     */
    // function getAllWaves() public view returns (Wave[] memory) {
    //     return waves;
    // }
    function getAllWaves() public view returns (Wave[] memory) {
        Wave[] memory _waves = new Wave[](totalWaves);
        for(uint i=0; i < totalWaves; i++) {
            //_waves.push[waves[i]];
            _waves[i] = waves[i];
        }
        return _waves;
    }

    function getTotalWaves() public view returns (uint256) {
        // Optional: Add this line if you want to see the contract print the value!
        // We'll also print it over in run.js as well.
        console.log("We have %d total waves!", totalWaves);
        return totalWaves;
    }
}