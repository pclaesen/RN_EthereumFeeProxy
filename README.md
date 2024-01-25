# Problem:
This repo tests Request Network [issue 1218](https://github.com/orgs/RequestNetwork/projects/3/views/7?pane=issue&itemId=42798183) and part of [issue 1149](https://github.com/orgs/RequestNetwork/projects/3/views/7?pane=issue&itemId=38409317). The issue reported was that the Request Network contract `EthereumFeeProxy` could not be called while using a 0 fee and that fees can't be send to a multisig.


The test results show the contract works as intended when using a 0 fee and a fee > 0.
The test `test_RevertWhenFeeToSmartContractAddress` shows that the _feeAddress can't be a smart contract that contains a fallback() or receive() function with a gas requirement > 2300 gas, as reported in the comments of issue 1149 (it's not exclusively smart wallet contract addresses that revert).

In this test example, the contract address of [Lido stETH](https://etherscan.io/address/0xae7ab96520de3a18e5e111b5eaab095312d7fe84#code) is used.

## Steps to run the test:
 * Install Foundry
 * Run `forge test -vvvvv --fork-url https://eth-mainnet.g.alchemy.com/v2/YOURAPIKEY` or `forge test -vvvvv --fork-url https://mainnet.infura.io/v3/YOURAPIKEY` (forking mainnet is mandatory)

## Test output with max verbosity:
```
Running 4 tests for test/RN_EthereumFeeProxy.t.sol:RN_EthereumFeeProxyTest
[PASS] test_PaymentToSmartContractAddress() (gas: 123693)
Traces:
  [123693] RN_EthereumFeeProxyTest::test_PaymentToSmartContractAddress()
    ├─ [0] VM::deal(0x7E5F4552091A69125d5DfCb7b8C2659029395Bdf, 100000000000000000000 [1e20])
    │   └─ ← ()
    ├─ [0] VM::prank(0x7E5F4552091A69125d5DfCb7b8C2659029395Bdf)
    │   └─ ← ()
    ├─ [104504] 0xfCFBcfc4f5A421089e3Df45455F7f4985FE2D6a8::transferWithReferenceAndFee{value: 10000000000000000000}(0xae7ab96520DE3A18E5e111B5EaAb095312D7fE84, 0x3078343934653536333332643332333433303031, 1000000000000000000 [1e18], 0x2B5AD5c4795c026514f8317c7a215E218DcCD6cF)
    │   ├─ [74851] 0xae7ab96520DE3A18E5e111B5EaAb095312D7fE84::fallback{value: 9000000000000000000}()
    │   │   ├─ [8263] 0xb8FFC3Cd6e7Cf5a098A1c92F48009765B24088Dc::getApp(0xf1f3eb40f5bc1ad1344716ced8b8a0431d840b5783aea1fd01786bc26f35ac0f, 0x3ca7c3e38968823ccb4c78ea688df41356f182ae1d159e4ee608d30d68cef320)
    │   │   │   ├─ [2820] 0x2b33CF282f867A7FF693A66e11B0FcC5552e4425::getApp(0xf1f3eb40f5bc1ad1344716ced8b8a0431d840b5783aea1fd01786bc26f35ac0f, 0x3ca7c3e38968823ccb4c78ea688df41356f182ae1d159e4ee608d30d68cef320) [delegatecall]
    │   │   │   │   └─ ← 0x00000000000000000000000017144556fd3424edc8fc8a4c940b2d04936d17eb
    │   │   │   └─ ← 0x00000000000000000000000017144556fd3424edc8fc8a4c940b2d04936d17eb
    │   │   ├─ [56113] 0x17144556fd3424EDC8Fc8A4C940B2D04936d17eb::fallback{value: 9000000000000000000}() [delegatecall]
    │   │   │   ├─  emit topic 0: 0x96a25c8ce0baabc1fdefd93e9ed25d8e092a3332f3aa9a41722b5697231d1d1a
    │   │   │   │       topic 1: 0x000000000000000000000000fcfbcfc4f5a421089e3df45455f7f4985fe2d6a8
    │   │   │   │           data: 0x0000000000000000000000000000000000000000000000007ce66c50e28400000000000000000000000000000000000000000000000000000000000000000000
    │   │   │   ├─ emit Transfer(from: 0x0000000000000000000000000000000000000000, to: 0xfCFBcfc4f5A421089e3Df45455F7f4985FE2D6a8, amount: 8999999999999999998 [8.999e18])
    │   │   │   ├─ emit TransferShares(param0: 0x0000000000000000000000000000000000000000, param1: 0xfCFBcfc4f5A421089e3Df45455F7f4985FE2D6a8, param2: 7792879426377719128 [7.792e18])
    │   │   │   └─ ← ()
    │   │   └─ ← ()
    │   ├─ [0] 0x2B5AD5c4795c026514f8317c7a215E218DcCD6cF::fallback{value: 1000000000000000000}()
    │   │   └─ ← ()
    │   ├─ [0] 0x7E5F4552091A69125d5DfCb7b8C2659029395Bdf::fallback()
    │   │   └─ ← ()
    │   ├─  emit topic 0: 0xa1c241e337c4610a9d0f881111e977e9dc8690c85fe2108897bb1483c66e6a96
    │   │       topic 1: 0x835eff2632c57d248ae796426d0ca72f1af5ac00261c1e1e345dd631757dc1e7
    │   │           data: 0x000000000000000000000000ae7ab96520de3a18e5e111b5eaab095312d7fe840000000000000000000000000000000000000000000000007ce66c50e28400000000000000000000000000000000000000000000000000000de0b6b3a76400000000000000000000000000002b5ad5c4795c026514f8317c7a215e218dccd6cf
    │   └─ ← ()
    └─ ← ()

[PASS] test_PaymentWithFee() (gas: 48864)
Traces:
  [48864] RN_EthereumFeeProxyTest::test_PaymentWithFee()
    ├─ [0] VM::deal(0x7E5F4552091A69125d5DfCb7b8C2659029395Bdf, 100000000000000000000 [1e20])
    │   └─ ← ()
    ├─ [0] VM::prank(0x7E5F4552091A69125d5DfCb7b8C2659029395Bdf)
    │   └─ ← ()
    ├─ [29653] 0xfCFBcfc4f5A421089e3Df45455F7f4985FE2D6a8::transferWithReferenceAndFee{value: 1000000000000000000}(0x2B5AD5c4795c026514f8317c7a215E218DcCD6cF, 0x3078343934653536333332643332333433303031, 100000000000000000 [1e17], 0x6813Eb9362372EEF6200f3b1dbC3f819671cBA69)
    │   ├─ [0] 0x2B5AD5c4795c026514f8317c7a215E218DcCD6cF::fallback{value: 900000000000000000}()
    │   │   └─ ← ()
    │   ├─ [0] 0x6813Eb9362372EEF6200f3b1dbC3f819671cBA69::fallback{value: 100000000000000000}()
    │   │   └─ ← ()
    │   ├─ [0] 0x7E5F4552091A69125d5DfCb7b8C2659029395Bdf::fallback()
    │   │   └─ ← ()
    │   ├─  emit topic 0: 0xa1c241e337c4610a9d0f881111e977e9dc8690c85fe2108897bb1483c66e6a96
    │   │       topic 1: 0x835eff2632c57d248ae796426d0ca72f1af5ac00261c1e1e345dd631757dc1e7
    │   │           data: 0x0000000000000000000000002b5ad5c4795c026514f8317c7a215e218dccd6cf0000000000000000000000000000000000000000000000000c7d713b49da0000000000000000000000000000000000000000000000000000016345785d8a00000000000000000000000000006813eb9362372eef6200f3b1dbc3f819671cba69
    │   └─ ← ()
    └─ ← ()

[PASS] test_PaymentZeroFee() (gas: 42186)
Traces:
  [42186] RN_EthereumFeeProxyTest::test_PaymentZeroFee()
    ├─ [0] VM::deal(0x7E5F4552091A69125d5DfCb7b8C2659029395Bdf, 100000000000000000000 [1e20])
    │   └─ ← ()
    ├─ [0] VM::prank(0x7E5F4552091A69125d5DfCb7b8C2659029395Bdf)
    │   └─ ← ()
    ├─ [22953] 0xfCFBcfc4f5A421089e3Df45455F7f4985FE2D6a8::transferWithReferenceAndFee{value: 1000000000000000000}(0x2B5AD5c4795c026514f8317c7a215E218DcCD6cF, 0x3078343934653536333332643332333433303031, 0, 0x6813Eb9362372EEF6200f3b1dbC3f819671cBA69)
    │   ├─ [0] 0x2B5AD5c4795c026514f8317c7a215E218DcCD6cF::fallback{value: 1000000000000000000}()
    │   │   └─ ← ()
    │   ├─ [0] 0x6813Eb9362372EEF6200f3b1dbC3f819671cBA69::fallback()
    │   │   └─ ← ()
    │   ├─ [0] 0x7E5F4552091A69125d5DfCb7b8C2659029395Bdf::fallback()
    │   │   └─ ← ()
    │   ├─  emit topic 0: 0xa1c241e337c4610a9d0f881111e977e9dc8690c85fe2108897bb1483c66e6a96
    │   │       topic 1: 0x835eff2632c57d248ae796426d0ca72f1af5ac00261c1e1e345dd631757dc1e7
    │   │           data: 0x0000000000000000000000002b5ad5c4795c026514f8317c7a215e218dccd6cf0000000000000000000000000000000000000000000000000de0b6b3a764000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006813eb9362372eef6200f3b1dbc3f819671cba69
    │   └─ ← ()
    └─ ← ()

[PASS] test_RevertWhenFeeToSmartContractAddress() (gas: 49915)
Traces:
  [49915] RN_EthereumFeeProxyTest::test_RevertWhenFeeToSmartContractAddress()
    ├─ [0] VM::deal(0x7E5F4552091A69125d5DfCb7b8C2659029395Bdf, 100000000000000000000 [1e20])
    │   └─ ← ()
    ├─ [0] VM::prank(0x7E5F4552091A69125d5DfCb7b8C2659029395Bdf)
    │   └─ ← ()
    ├─ [0] VM::expectRevert(custom error f4844814:)
    │   └─ ← ()
    ├─ [27531] 0xfCFBcfc4f5A421089e3Df45455F7f4985FE2D6a8::transferWithReferenceAndFee{value: 10000000000000000000}(0x2B5AD5c4795c026514f8317c7a215E218DcCD6cF, 0x3078343934653536333332643332333433303031, 1000000000000000000 [1e18], 0xae7ab96520DE3A18E5e111B5EaAb095312D7fE84)
    │   ├─ [0] 0x2B5AD5c4795c026514f8317c7a215E218DcCD6cF::fallback{value: 9000000000000000000}()
    │   │   └─ ← ()
    │   ├─ [2218] 0xae7ab96520DE3A18E5e111B5EaAb095312D7fE84::fallback{value: 1000000000000000000}()
    │   │   └─ ← EvmError: Revert
    │   └─ ← EvmError: Revert
    └─ ← ()

Test result: ok. 4 passed; 0 failed; 0 skipped; finished in 4.72s
```
  Ran 1 test suites: 4 tests passed, 0 failed, 0 skipped (4 total tests)
