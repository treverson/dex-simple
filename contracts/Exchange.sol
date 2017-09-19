pragma solidity ^0.4.8;

import "./Token.sol";

contract Exchange {

    event Placed(address haveAddress, uint256 haveAmount, address needAddress, uint256 needValue);
    event Executed(address haveAddress, uint256 haveAmount, address needAddress, uint256 needValue);

    struct Order {
        address owner;
        uint256 haveAmount;
        uint256 needAmount;
    }

    mapping (address => mapping (address => Order)) orders; //todo тут список order'ов должен быть

    function exchange(address haveAddress, uint256 haveAmount, address needAddress, uint256 needAmount) {
        Token haveToken = Token(haveAddress);
        require(haveToken.balanceOf(msg.sender) >= haveAmount && haveToken.allowance(msg.sender, address(this)) >= haveAmount);
        Order storage order = orders[needAddress][haveAddress];
        if (order.haveAmount == needAmount && order.needAmount == haveAmount) {
            Token needToken = Token(needAddress);
            if (needToken.balanceOf(order.owner) >= needAmount && needToken.allowance(order.owner, address(this)) >= needAmount) {
                haveToken.transferFrom(msg.sender, order.owner, haveAmount);//todo обработать false?
                needToken.transferFrom(order.owner, msg.sender, needAmount);//todo обработать false?
                Executed(needAddress, needAmount, haveAddress, haveAmount);
            } else {
                orders[haveAddress][needAddress] = Order(msg.sender, haveAmount, needAmount);
                Placed(haveAddress, haveAmount, needAddress, needAmount);
            }
        } else {
            orders[haveAddress][needAddress] = Order(msg.sender, haveAmount, needAmount);
            Placed(haveAddress, haveAmount, needAddress, needAmount);
        }
    }
}