// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;

    constructor() {
        console.log("The start of a SmartContract for sharing Waves");
    }

    function wave(string calldata waveMessage) public {
        totalWaves += 1;
        console.log("%s has waved!", msg.sender);
        // if(waveMessage) {
        if(bytes(waveMessage).length != 0) {
            // console.log('  - with message: ' + waveMessage);
            // console.log(string.concat('  - with message: ', waveMessage));
            // string memory output = string.concat('  - with message:', waveMessage);
            console.log(waveMessage);
        }
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("We have %d total waves!", totalWaves);
        return totalWaves;
    }
}