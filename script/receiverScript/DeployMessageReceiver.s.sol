// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {HelpConfig} from "./HelperReceiveConfig.s.sol";
import {MessageReceiver} from "../../src/MessageReceiver.sol";

// Address: 0x4fdd9B2bB56b699b237D4F14608f1e30caA6C3e6


contract DeployMessageReceiver is Script {
    function run() external returns(MessageReceiver, HelpConfig) {
        HelpConfig helpConfig = new HelpConfig();
        (address router) = helpConfig.activeNetworkConfig();
        vm.startBroadcast();
        MessageReceiver messageReceiver = new MessageReceiver(router);
        vm.stopBroadcast();
        return (messageReceiver, helpConfig);
    }
}