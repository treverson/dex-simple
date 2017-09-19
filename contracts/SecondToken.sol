pragma solidity ^0.4.8;

import "./HumanStandardToken.sol";

contract SecondToken is HumanStandardToken {
    function SecondToken() HumanStandardToken(10000, "Second Token", 0, "SND") {

    }
}