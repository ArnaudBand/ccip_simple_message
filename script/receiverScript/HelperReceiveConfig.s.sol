// SPDX-License-Identier: MIT
pragma solidity ^0.8.19;

contract HelpConfig {
    struct NetworkConfig {
        address router;
    }

    NetworkConfig public activeNetworkConfig;

    constructor() {
            activeNetworkConfig = getSepoliaEthConfig();
    }

    function getSepoliaEthConfig() public pure returns (NetworkConfig memory) {
        return NetworkConfig({
            router: 0x0BF3dE8c5D3e8A2B34D2BEeB17ABfCeBaf363A59
        });
    }
}