// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract HelpConfig {
    struct NetworkConfig {
        address router;
        address link;
    }

    NetworkConfig public activeNetworkConfig;

    constructor() {
            activeNetworkConfig = getAvalancheEthConfig();
    }

    function getAvalancheEthConfig() public pure returns (NetworkConfig memory) {
        return NetworkConfig({
            router: 0xF694E193200268f9a4868e4Aa017A0118C9a8177,
            link: 0x0b9d5D9136855f6FEc3c0993feE6E9CE8a297846
        });
    }
}
