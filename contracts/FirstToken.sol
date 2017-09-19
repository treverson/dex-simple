pragma solidity ^0.4.8;

import "./HumanStandardToken.sol";

contract FirstToken is HumanStandardToken {
    function FirstToken() HumanStandardToken(5000, "First Token", 0, "FST") {

    }
}