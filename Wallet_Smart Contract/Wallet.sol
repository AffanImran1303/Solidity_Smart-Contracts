// SPDX-License-Identifier: GPL-3.0

pragma solidity < 0.8.25;

contract Wallet{

    address public owner;
    string public str;

    constructor(){
        owner=msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender==owner,"You don't own this wallet!");
        _;
    }

    modifier checkBalance(uint amount){
        require(address(this).balance>amount,"Insufficient Balance");
        _;
    }
    /**Contract related functions**/
    function transferToContract() external payable {
       str="Amount Transferred Successfully";
    }


    function transferToUserViaContract(address payable  _to, uint _weiAmount) external onlyOwner checkBalance(_weiAmount){
    //    require(address(this).balance>_weiAmount,"Insufficient Balance");
       _to.transfer(_weiAmount);
    }


    function withdrawFromContract(uint _weiAmount) external onlyOwner{
        payable(owner).transfer(_weiAmount);
    }


    function getContractBalanceInWei() external view returns (uint) {
       return address(this).balance;
    }


     /**User related functions**/
    function transferToUserViaMsgValue(address  _to) external payable checkBalance(msg.value){
        payable(_to).transfer(msg.value);
    
    }


    function receiveFromUser() external payable checkBalance(msg.value){
        payable(owner).transfer(msg.value);
    }


    function getOwnerBalanceInWei() external view returns(uint){
       return address(this).balance;
    }


    receive() external payable {
       
    }


    fallback() external  {
       
    }





}

