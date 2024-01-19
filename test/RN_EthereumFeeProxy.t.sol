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

    address RNEthereumFeeProxyaddress = 0xC6E23a20C0a1933ACC8E30247B5D1e2215796C1F; //Polygon Mainnet address for EthereumFeeProxy contract

    function test_PaymentWithFee() public payable {

        address alice = vm.addr(1);
        address payable bob = payable(vm.addr(2));
        address payable feeAddress = payable(vm.addr(3));

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

        address alice = vm.addr(1);
        address payable bob = payable(vm.addr(2));
        address payable feeAddress = payable(vm.addr(3));

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
}
