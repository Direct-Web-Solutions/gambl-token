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

library Address {

    function isContract(address account) internal view returns (bool) {
        bytes32 codehash;
        bytes32 accountHash = 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470;
        assembly { codehash := extcodehash(account) }
        return (codehash != accountHash && codehash != 0x0);
    }

    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, "Address: insufficient balance");
        (bool success, ) = recipient.call{ value: amount }("");
        require(success, "Address: unable to send value, recipient may have reverted.");
    }

    function functionCall(address target, bytes memory data) internal returns (bytes memory) {
      return functionCall(target, data, "Address: low-level call failed.");
    }

    function functionCall(address target, bytes memory data, string memory errorMessage) internal returns (bytes memory) {
        return _functionCallWithValue(target, data, 0, errorMessage);
    }

    function functionCallWithValue(address target, bytes memory data, uint256 value) internal returns (bytes memory) {
        return functionCallWithValue(target, data, value, "Address: low-level call with value failed.");
    }
    
    function functionCallWithValue(address target, bytes memory data, uint256 value, string memory errorMessage) internal returns (bytes memory) {
        require(address(this).balance >= value, "Address: insufficient balance for call.");
        return _functionCallWithValue(target, data, value, errorMessage);
    }
    
    function _functionCallWithValue(address target, bytes memory data, uint256 weiValue, string memory errorMessage) private returns (bytes memory) {
        require(isContract(target), "Address: call to non-contract.");
        (bool success, bytes memory returndata) = target.call{ value: weiValue }(data);
        if (success) {
            return returndata;
        } else {
            if (returndata.length > 0) {
                assembly {
                    let returndata_size := mload(returndata)
                    revert(add(32, returndata), returndata_size)
                }
            } else {
                revert(errorMessage);
            }
        }
    }

}
