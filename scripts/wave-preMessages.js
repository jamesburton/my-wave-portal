const main = async () => {
    // const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
    // const waveContract = await waveContractFactory.deploy();
    // await waveContract.deployed();
    // console.log("Contract deployed to:", waveContract.address);

    //const [owner, randomPerson] = await hre.ethers.getSigners();
    const [me] = await hre.ethers.getSigners();
    // const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
    // const waveContract = await waveContractFactory.deploy();
    // await waveContract.deployed();
    const waveContractFactory = await hre.ethers.getContractFactory("WavePortal");
    const contractId = (
      // TEMPORARY SO DOESN'T WORK:- process.env.HARDHAT_NETWORK === 'hardhat' ? process.env.DEV_CONTRACT_ID :
      process.env.HARDHAT_NETWORK === 'localhost' ? process.env.LOCALHOST_CONTRACT_ID :
      process.env.HARDHAT_NETWORK === 'rinkeby' ? process.env.STAGING_CONTRACT_ID :
      process.env.HARDHAT_NETWORK === 'mainnet' ? process.env.CONTRACT_ID :
      undefined);
    console.log(`contractId=${contractId}`);
    const waveContract = await waveContractFactory.attach(contractId);

    // console.log("Contract deployed to:", waveContract.address);
    console.log("Connected to contract:", waveContract.address);
    console.log("Connected with user:", me.address);

    let waveCount;
    waveCount = await waveContract.getTotalWaves();

    //let waveTxn = await waveContract.wave('Example message');
    let waveTxn = await waveContract.wave();
    await waveTxn.wait();

    waveCount = await waveContract.getTotalWaves();
  };
  
  const runMain = async () => {
    try {
      await main();
      process.exit(0); // exit Node process without error
    } catch (error) {
      console.log(error);
      process.exit(1); // exit Node process while indicating 'Uncaught Fatal Exception' error
    }
    // Read more about Node exit ('process.exit(num)') status codes here: https://stackoverflow.com/a/47163396/7974948
  };
  
  runMain();