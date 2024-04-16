// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";
import {HelpConfig} from "./HelperSendConfig.s.sol";
import {MessageSender} from "../../src/MessageSender.sol";

// Address: 0xd1A04634b5Ab411DB40b45a21ab059D9aC3924eA

contract DeployMessageSender is Script {
    function run() external returns(MessageSender, HelpConfig) {
        HelpConfig helpConfig = new HelpConfig();
        (address router, address link) = helpConfig.activeNetworkConfig();
        vm.startBroadcast();
        MessageSender messageSender = new MessageSender(router, link);
        vm.stopBroadcast();
        return (messageSender, helpConfig);
    }
}