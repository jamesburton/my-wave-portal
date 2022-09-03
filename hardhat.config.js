require("dotenv").config();
require("@nomicfoundation/hardhat-toolbox");
require("@nomicfoundation/hardhat-chai-matchers");
require("@nomiclabs/hardhat-ethers");

task("accounts", "Prints the list of accounts", async () => {
  const accounts = await ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

// Display config if running (HARDHAT_NETWORK is missing on compile)
if(process.env.HARDHAT_NETWORK) {
  console.log('nodenv=', process.env.NODE_ENV ?? typeof process.env.NODE_ENV);
  // console.log(JSON.stringify(process.env));
  console.log('HARDHAT_NETWORK=', process.env.HARDHAT_NETWORK ?? typeof process.env.HARDHAT_NETWORK);
}

if(process.env.NODE_ENV === 'production') {
  if(!process.env.PROD_QUICKNODE_URL?.length)
    throw new Error('PROD_QUICKNODE_URL environment variable is missing');
  if(!process.env.PRIVATE_KEY?.length)
    throw new Error('PRIVATE_KEY environment variable is missing');
} else {
  if(!process.env.STAGING_QUICKNODE_URL?.length)
    throw new Error(`STAGING_QUICKNODE_URL environment variable is missing (NODE_ENV=${process.env.NODE_ENV})`);
  if(!process.env.STAGING_PRIVATE_KEY?.length)
    throw new Error(`STAGING_PRIVATE_KEY environment variable is missing (NODE_ENV=${process.env.NODE_ENV})`);
}

var networks = {};
if(process.env.STAGING_QUICKNODE_URL?.length)
  networks.rinkeby = {
    chainId: 4,
    // chainId: 1337, // See https://hardhat.org/hardhat-network/docs/metamask-issue
    // This value will be replaced on runtime
    url: process.env.STAGING_QUICKNODE_URL,
    accounts: [process.env.STAGING_PRIVATE_KEY],
  };
if(process.env.PROD_QUICKNODE_URL?.length)
  networks.mainnet = {
    chainId: 1,
    // chainId: 1337,
    url: process.env.PROD_QUICKNODE_URL,
    accounts: [process.env.PRIVATE_KEY],
  };
const defaultNetwork = 'localhost';

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.9",
  // Configure networks (such as "rinkeby" TestNet)
  // networks: {
  //   rinkeby: process.env.STAGING_QUICKNODE_URL && {
  //     // This value will be replaced on runtime
  //     url: process.env.STAGING_QUICKNODE_URL,
  //     accounts: [process.env.STAGING_PRIVATE_KEY],
  //   },
  //   mainnet: process.env.PROD_QUICKNODE_URL && {
  //     chainId: 1,
  //     url: process.env.PROD_QUICKNODE_URL,
  //     accounts: [process.env.PRIVATE_KEY],
  //   },
  // },
  networks,
  defaultNetwork,
};
