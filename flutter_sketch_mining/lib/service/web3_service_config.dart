
part of 'web3_service.dart';

// For development only
class _Web3ServiceConfig {
  var rpc = "https://testnet.skalenodes.com/v1/lanky-ill-funny-testnet";
  var wss = 'wss://testnet.skalenodes.com/v1/ws/lanky-ill-funny-testnet';

  var fundMgrAddr = '0x3c029F8F1Fa7A1c9Af16532522C9b7FB2A3367E2';
  var fundMgrPkey = '0x22d32faab7a6aa7fec72f621ad227b176ea621c0df913b885393bf181800218f';
  var dltgAddress = '0x7EBBAD5Ee9989A60c5E998E4839D190a3deAA153';
  var chainId     = '37084624';


  // test data
  List<String> addrs = [
    "0x3c029F8F1Fa7A1c9Af16532522C9b7FB2A3367E2",
    "0xac2f8290D7BC3e104b2844AaD541B705D51Eb8e8",
    "0x8f2601f98480851d89A22f23F250FdAfbD9409DD",
    "0x118159c3ad9032fD7ed1c4F5c1E92796B27F7238",
    "0x4E66020BE5388F76F51F0C4C10219a9c4B8979fE"
  ];

  List<Decimal> amounts = [
    Decimal.parse('1.01'),
    Decimal.parse('1.03'),
    Decimal.parse('1.05'),
    Decimal.parse('1.07'),
    Decimal.parse('1.09'),
  ];

  var abi = [
    {
      "inputs": [
        {
          "internalType": "address payable[]",
          "name": "recipients",
          "type": "address[]"
        },
        {
          "internalType": "uint256[]",
          "name": "amounts",
          "type": "uint256[]"
        }
      ],
      "name": "transport",
      "outputs": [],
      "stateMutability": "payable",
      "type": "function"
    }
  ];
}