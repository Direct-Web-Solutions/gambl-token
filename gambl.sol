/**
    Submitted for verification at BscScan.com on ####-##-##

    #GAMBL
    
    General:
    
    A cross-platform token designed for gaming and lottery
    integration from the ground up. A smart contract designed
    to deploy ticket information to the user along with a
    database to check how many tokens they may have won. Rewards
    are paid out automatically once every 5 days to the prize
    pool winners.
    
    Notice:
    
    There is no minning or minting of this token. The initial
    team will receive 10% of total token supply with the rest
    of the tokens locked for general consumption by primarily
    PCS and UniSwap users.

*/

pragma solidity ^0.6.12;

interface IERC20 {

    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

}

library OveflowMath {

    function add(uint256 valueA, uint256 valueB) internal pure returns (uint256) {
        uint256 totalValue = valueA + valueB;
        require(totalValue >= valueA, "Error: there was an addition overflow.");
        return totalValue;
    }

    function sub(uint256 valueA, uint256 valueB) internal pure returns (uint256) {
        return sub(valueA, valueB, "Error: there was a subtraction overflow.");
    }

    function sub(uint256 valueA, uint256 valueB, string memory errorMessage) internal pure returns (uint256) {
        require(valueB <= valueA, errorMessage);
        uint256 totalValue = valueA - valueB;
        return totalValue;
    }

    function mul(uint256 valueA, uint256 valueB) internal pure returns (uint256) {
        if (valueA == 0) {
            return 0;
        }
        uint256 totalValue = valueA * valueB;
        require(totalValue / valueA == valueB, "Error: there was a multiplication overflow.");
        return totalValue;
    }
    
    function div(uint256 valueA, uint256 valueB) internal pure returns (uint256) {
        return div(valueA, valueB, "Error: you cannot divide by zero.");
    }

    function div(uint256 valueA, uint256 valueB, string memory errorMessage) internal pure returns (uint256) {
        require(valueB > 0, errorMessage);
        uint256 totalValue = valueA / valueB;
        return totalValue;
    }

    function mod(uint256 valueA, uint256 valueB) internal pure returns (uint256) {
        return mod(valueA, valueB, "Error: cannot revert by zero.");
    }

    function mod(uint256 valueA, uint256 valueB, string memory errorMessage) internal pure returns (uint256) {
        require(valueB != 0, errorMessage);
        return valueA % valueB;
    }

}

abstract contract Context {

    function _msgSender() internal view virtual returns (address payable) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes memory) {
        this;
        return msg.data;
    }

}
