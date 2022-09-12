const main = async () => {
    const [deployer] = await hre.ethers.getSigners();
    const accountBalance = await deployer.getBalance();
  
    console.log("Deploying contracts with account: ", deployer.address);
    console.log("Account balance: ", accountBalance.toString());
  
    const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
    // const waveContract = await waveContractFactory.deploy();
    // Deploy with contract funds for prizes
    // const funds = "0.1";
    const initialContractFunds = process.env.HARDHAT_NETWORK === 'mainnet' ? "0.01" : "0.1";
    const waveContract = await waveContractFactory.deploy({
      value: hre.ethers.utils.parseEther(initialContractFunds),
    });
    await waveContract.deployed();
  
    console.log("WavePortal address: ", waveContract.address);

    /*
      * Get Contract balance
      */
    let contractBalance = await hre.ethers.provider.getBalance(
      waveContract.address
    );
    console.log(
      "Contract balance:",
      hre.ethers.utils.formatEther(contractBalance)
    );

    /*
    let waveCount;
    waveCount = await waveContract.getTotalWaves();
    console.log(waveCount.toNumber());
  
    /**
     * Let's send a few waves!
     * /
    let waveTxn = await waveContract.wave("A message!");
    await waveTxn.wait(); // Wait for the transaction to be mined
  
    const [_, randomPerson] = await hre.ethers.getSigners();
    waveTxn = await waveContract.connect(randomPerson).wave("Another message!");
    await waveTxn.wait(); // Wait for the transaction to be mined
  
    let allWaves = await waveContract.getAllWaves();
    console.log(allWaves);
    */

    if(process.env.HARDHAT_NETWORK !== 'mainnet') {
      // *** Test a wave and re-check balance
      /*
        * Send Wave
        */
      let waveTxn = await waveContract.wave("A message!");
      await waveTxn.wait();

      /*
      * Get Contract balance to see what happened!
      */
      contractBalance = await hre.ethers.provider.getBalance(waveContract.address);
      console.log(
        "Contract balance:",
        hre.ethers.utils.formatEther(contractBalance)
      );

      let allWaves = await waveContract.getAllWaves();
      console.log(allWaves);
    }
  };
  
  const runMain = async () => {
    try {
      await main();
      process.exit(0);
    } catch (error) {
      console.log(error);
      process.exit(1);
    }
  };
  
  runMain();