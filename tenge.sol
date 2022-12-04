// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;


contract Tenge {

    string public constant name = "Tenge";
    string public constant symbol = "KZT";
    uint8 public constant decimals = 18;

    uint public _totalSupply  = 1000000e18;
    mapping(address => uint) balance_changer;
    mapping(address => mapping(address => uint)) public allowance;
    mapping(address => bool) isBlacklist;


    

    function totalSupply() external view returns(uint){
        return _totalSupply;
    }

    function balanceOF(address account) external view returns(uint){
        return balance_changer[account];
    }

    function transfer(address recipient, uint amount) external returns(bool){
        require(!isBlacklist[msg.sender], "You are on BlackList");
        balance_changer[msg.sender] -= amount;
        balance_changer[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    function allowance123(address owner, address sender) external view returns(uint){
        return allowance[owner][sender];
    }

    function mint() public {
        balance_changer[msg.sender] += 500000000000000000000;
    }

    function approve(address spender, uint amount) external returns(bool){
        allowance[msg.sender][spender] = amount;
        emit Approve(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(address sender, address recipient, uint amount) external returns(bool){
        allowance[sender][recipient] -=amount;
        balance_changer[sender] -= amount;
        balance_changer[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    function blacklist(address bad_guy) external{
        isBlacklist[bad_guy] = true;
    }
    function un_blacklist(address bad_guy) external{
        isBlacklist[bad_guy] = false;
    }

    function is_blacklist(address bad_guy) external view  returns(bool){
        return isBlacklist[bad_guy];
    }

    function balanceOf(address tokenOwner) public view returns (uint) {
        return balance_changer[tokenOwner];
    }


    event Transfer(address indexed from, address indexed to, uint amount);
    event Approve(address indexed owner, address indexed spender, uint amount);



}