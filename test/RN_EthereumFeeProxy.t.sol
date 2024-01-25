// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Test, console2} from "forge-std/Test.sol";

interface IEthereumFeeProxy {
    function transferWithReferenceAndFee(
        address payable _to,
        bytes calldata _paymentReference,
        uint256 _feeAmount,
        address payable _feeAddress
    ) external payable;
}

contract RN_EthereumFeeProxyTest is Test {

    address RNEthereumFeeProxyaddress = 0xfCFBcfc4f5A421089e3Df45455F7f4985FE2D6a8; //Mainnet address for EthereumFeeProxy contract

    address alice = vm.addr(1);
    address payable bob = payable(vm.addr(2));
    address payable feeAddress = payable(vm.addr(3));
    address payable smartContractReceiver = payable(0xae7ab96520DE3A18E5e111B5EaAb095312D7fE84); //Lido stETH token contract address

    function test_PaymentWithFee() public payable {

        vm.deal(alice, 100 ether);
        bytes memory paymentReference1 = "0x494e56332d32343001";

        vm.prank(alice);
        IEthereumFeeProxy(RNEthereumFeeProxyaddress).transferWithReferenceAndFee{value: 1 ether} ( 
            bob,
            paymentReference1,
            0.1 ether,
            feeAddress       
        );
    }

    function test_PaymentZeroFee() public payable {

        vm.deal(alice, 100 ether);
        bytes memory paymentReference1 = "0x494e56332d32343001";

        vm.prank(alice);
        IEthereumFeeProxy(RNEthereumFeeProxyaddress).transferWithReferenceAndFee{value: 1 ether} ( 
            bob,
            paymentReference1,
            0 ether,
            feeAddress       
        );
    }

    function test_PaymentToSmartContractAddress() external payable{
        
        vm.deal(alice, 100 ether);
        bytes memory paymentReference1 = "0x494e56332d32343001";

        vm.prank(alice);
        IEthereumFeeProxy(RNEthereumFeeProxyaddress).transferWithReferenceAndFee{value: 10 ether} ( 
            smartContractReceiver,
            paymentReference1,
            1 ether,
            bob
        );
    }

    function test_RevertWhenFeeToSmartContractAddress() external payable{
        
        vm.deal(alice, 100 ether);
        bytes memory paymentReference1 = "0x494e56332d32343001";

        vm.prank(alice);
        vm.expectRevert();
        IEthereumFeeProxy(RNEthereumFeeProxyaddress).transferWithReferenceAndFee{value: 10 ether} ( 
            bob,
            paymentReference1,
            1 ether,
            smartContractReceiver
        );
    }
}
