// Web3Mint.js
const { expect } = require('chai');
const { ethers } = require('hardhat');

describe('Web3Mint', () => {
  it('Should return the nft', async() => {
    const Mint = await ethers.getContractFactory('Web3Mint');
    const mintContract = await Mint.deploy();
    await mintContract.deployed();

    const [owner, addr1] = await ethers.getSigners();

    let nftName = 'poker';
    let ipfsCID = 'bafybeihwuiofsekft3tmrxiw4c7xr6czdbaquuarjxkys5ko66ncqwcjju';

    await mintContract.connect(owner).mintIpfsNFT(nftName, ipfsCID); // tokenId: 0
    await mintContract.connect(addr1).mintIpfsNFT(nftName, ipfsCID); // tokenId: 1

    console.log(await mintContract.tokenURI(0));
    console.log(await mintContract.tokenURI(1));
  });
});