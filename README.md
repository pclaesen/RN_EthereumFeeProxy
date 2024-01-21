# Problem:
This repo tests Request Network [issue 1218](https://github.com/orgs/RequestNetwork/projects/3/views/7?pane=issue&itemId=42798183) and part of [issue 1149](https://github.com/orgs/RequestNetwork/projects/3/views/7?pane=issue&itemId=38409317). The issue reported was that the Request Network contract `EthereumFeeProxy` could not be called while using a 0 fee.

The test results show the contract works as intended when using a 0 fee and a fee > 0.

## Steps to run the test:
 * Install Foundry
 * Run `forge test -vvvvv --fork-url https://polygon-mainnet.g.alchemy.com/v2/YOURAPIKEY` or `forge test -vvvvv --fork-url https://mainnet.infura.io/v3/YOURAPIKEY` (forking mainnet is mandatory)

## Test output with max verbosity:

    Running 2 tests for test/RN_EthereumFeeProxy.t.sol:RN_EthereumFeeProxyTest
    [PASS] test_PaymentWithFee() (gas: 43085)
    Traces:
      [43085] RN_EthereumFeeProxyTest::test_PaymentWithFee()
        ├─ [0] VM::addr(1) [staticcall]
        │   └─ ← 0x7E5F4552091A69125d5DfCb7b8C2659029395Bdf
        ├─ [0] VM::addr(2) [staticcall]
        │   └─ ← 0x2B5AD5c4795c026514f8317c7a215E218DcCD6cF
        ├─ [0] VM::addr(3) [staticcall]
        │   └─ ← 0x6813Eb9362372EEF6200f3b1dbC3f819671cBA69
        ├─ [0] VM::deal(0x7E5F4552091A69125d5DfCb7b8C2659029395Bdf, 100000000000000000000 [1e20])
        │   └─ ← ()
        ├─ [0] VM::prank(0x7E5F4552091A69125d5DfCb7b8C2659029395Bdf)
        │   └─ ← ()
        ├─ [26253] 0xC6E23a20C0a1933ACC8E30247B5D1e2215796C1F::transferWithReferenceAndFee{value: 1000000000000000000}(0x2B5AD5c4795c026514f8317c7a215E218DcCD6cF, 0x3078343934653536333332643332333433303031, 100000000000000000 [1e17], 0x6813Eb9362372EEF6200f3b1dbC3f819671cBA69)
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
    
    [PASS] test_PaymentZeroFee() (gas: 36341)
    Traces:
      [36341] RN_EthereumFeeProxyTest::test_PaymentZeroFee()
        ├─ [0] VM::addr(1) [staticcall]
        │   └─ ← 0x7E5F4552091A69125d5DfCb7b8C2659029395Bdf
        ├─ [0] VM::addr(2) [staticcall]
        │   └─ ← 0x2B5AD5c4795c026514f8317c7a215E218DcCD6cF
        ├─ [0] VM::addr(3) [staticcall]
        │   └─ ← 0x6813Eb9362372EEF6200f3b1dbC3f819671cBA69
        ├─ [0] VM::deal(0x7E5F4552091A69125d5DfCb7b8C2659029395Bdf, 100000000000000000000 [1e20])
        │   └─ ← ()
        ├─ [0] VM::prank(0x7E5F4552091A69125d5DfCb7b8C2659029395Bdf)
        │   └─ ← ()
        ├─ [19553] 0xC6E23a20C0a1933ACC8E30247B5D1e2215796C1F::transferWithReferenceAndFee{value: 1000000000000000000}(0x2B5AD5c4795c026514f8317c7a215E218DcCD6cF, 0x3078343934653536333332643332333433303031, 0, 0x6813Eb9362372EEF6200f3b1dbC3f819671cBA69)
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
    
    Test result: ok. 2 passed; 0 failed; 0 skipped; finished in 2.25s
     
    Ran 1 test suites: 2 tests passed, 0 failed, 0 skipped (2 total tests)