import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";

const config: HardhatUserConfig = {
  solidity: "0.8.17",
  defaultNetwork: "matic",
  networks: {
    matic: {
      url: "https://rpc-mumbai.maticvigil.com",
      accounts: [process.env.REACT_APP_PRIVATE_KEY]
   }
  },
  etherscan: {
    apiKey: process.env.REACT_APP_ETHERSCAN_KEY
  }
};

export default config;
