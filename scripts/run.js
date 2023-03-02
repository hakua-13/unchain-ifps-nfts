const main = async() => {
  const nftContractFactory = await hre.ethers.getContractFactory('Web3Mint');
  // hardhatがローカルのethereumネットワークを作成する
  const nftContract = await nftContractFactory.deploy();
  await nftContract.deployed();
  console.log('contract deployed to: ', nftContract.address);

  let txn = await nftContract.mintIpfsNFT(
    'poker',
    'bafybeihwuiofsekft3tmrxiw4c7xr6czdbaquuarjxkys5ko66ncqwcjju'
  );
  await txn.wait();

  txn = await nftContract.mintIpfsNFT(
    'poker',
    'bafybeihwuiofsekft3tmrxiw4c7xr6czdbaquuarjxkys5ko66ncqwcjju'
  );
  await txn.wait();

  txn = await nftContract.mintIpfsNFT(
    'poker',
    'bafybeihwuiofsekft3tmrxiw4c7xr6czdbaquuarjxkys5ko66ncqwcjju'
  );
  await txn.wait();

  let returnTokenUri = await nftContract.tokenURI(0);
  console.log('tokenURI: ', returnTokenUri);
};

const runMain = async() => {
  try{
    await main();
    process.exit(0);
  }catch(error){
    console.log(error);
    process.exit(1);
  };
};

runMain();