require("@nomicfoundation/hardhat-toolbox");
require("@nomicfoundation/hardhat-chai-matchers");
require("@nomiclabs/hardhat-ethers");

task("accounts", "Prints the list of accounts", async () => {
  const accounts = await ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

if(process.env.NODE_ENV === 'production') {
  if(!process.env.PROD_QUICKNODE_URL?.length)
    throw new Error('PROD_QUICKNODE_URL environment variable is missing');
  if(!process.env.PRIVATE_KEY?.length)
    throw new Error('PRIVATE_KEY environment variable is missing');
} else {
  if(!process.env.STAGING_QUICKNODE_URL?.length)
    throw new Error('STAGING_QUICKNODE_URL environment variable is missing');
  if(!process.env.STAGING_PRIVATE_KEY?.length)
    throw new Error('STAGING_PRIVATE_KEY environment variable is missing');
}

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.9",
  // Configure networks (such as "rinkeby" TestNet)
  networks: {
    rinkeby: {
      // This value will be replaced on runtime
      url: process.env.STAGING_QUICKNODE_URL,
      accounts: [process.env.STAGING_PRIVATE_KEY],
    },
    mainnet: {
      chainId: 1,
      url: process.env.PROD_QUICKNODE_URL,
      accounts: [process.env.PRIVATE_KEY],
    },
  },
};
