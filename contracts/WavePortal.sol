// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;
    address /*payable*/ public owner;
    string[] messages;

    constructor() {
        console.log("The start of a SmartContract for sharing Waves");
    }

    function wave(string calldata message) public {
        totalWaves += 1;
        console.log("%s has waved!", msg.sender);
        // if(waveMessage) {
        if(bytes(message).length != 0) {
            // console.log('  - with message: ' + message);
            // console.log(string.concat('  - with message: ', message));
            // string memory output = string.concat('  - with message:', message);
            console.log(message);
            messages.push(message);
        }
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("We have %d total waves!", totalWaves);
        return totalWaves;
    }

    function getMessages() public view returns (string[] memory) {
        return messages;
    }
}