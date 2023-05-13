import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
const { priv, bscscanApiKey } = require('./secrets.json');
require('hardhat-abi-exporter');


require('@nomiclabs/hardhat-ethers');
require("@nomiclabs/hardhat-etherscan");



const config: HardhatUserConfig = {
  networks: {
    testnet: {
      url: `https://data-seed-prebsc-1-s1.binance.org:8545`,
      accounts: [priv]
    },
    mainnet: {
      url: `https://bsc-dataseed.binance.org/`,
      accounts: [priv]
    }
  },
// @ts-ignore
  abiExporter: {
    path: './data/abi',
    runOnCompile: true,
    clear: true,
    flat: true,
    only: [],
    spacing: 2,
    pretty: true,
  },

  etherscan: {
    // Your API key for Etherscan
    // Obtain one at https://bscscan.com/
    apiKey: {
      bscTestnet: bscscanApiKey
    }
},

  solidity: "0.8.18",
};

export default config;
