// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {IERC20} from
    "@chainlink/contracts-ccip/src/v0.8/vendor/openzeppelin-solidity/v4.8.3/contracts/token/ERC20/IERC20.sol";
import {IRouterClient} from "@chainlink/contracts-ccip/src/v0.8/ccip/interfaces/IRouterClient.sol";
import {Client} from "@chainlink/contracts-ccip/src/v0.8/ccip/libraries/Client.sol";
import {Withdraw} from "./utils/Withdraw.sol";

/**
 * THIS IS AN EXAMPLE CONTRACT THAT USES HARDCODED VALUES FOR CLARITY.
 * THIS IS AN EXAMPLE CONTRACT THAT USES UN-AUDITED CODE.
 * DO NOT USE THIS CODE IN PRODUCTION.
 */
contract MessageSender is Withdraw {
    enum PayFeesIn {
        Native,
        LINK
    }

    address immutable i_router;
    IERC20 private immutable linkToken;

    event MessageSent(bytes32 messageId);

    constructor(address router, address link) {
        i_router = router;
        linkToken = IERC20(link);
    }

    receive() external payable {}

    function send(uint64 destinationChainSelector, address receiver, string memory messageText, PayFeesIn payFeesIn)
        external
        returns (bytes32 messageId)
    {
        Client.EVM2AnyMessage memory message = Client.EVM2AnyMessage({
            receiver: abi.encode(receiver),
            data: abi.encode(messageText),
            tokenAmounts: new Client.EVMTokenAmount[](0),
            extraArgs: "",
            feeToken: payFeesIn == PayFeesIn.LINK ? address(linkToken) : address(0)
        });

        uint256 fee = IRouterClient(i_router).getFee(destinationChainSelector, message);

        if (payFeesIn == PayFeesIn.LINK) {
            linkToken.approve(i_router, fee);
            messageId = IRouterClient(i_router).ccipSend(destinationChainSelector, message);
        } else {
            messageId = IRouterClient(i_router).ccipSend{value: fee}(destinationChainSelector, message);
        }

        emit MessageSent(messageId);
    }
}
