// Web3Mint.sol
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;
// openzeppelinのコントラクトをインポートする
// import '@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol';
import '@openzeppelin/contracts/token/ERC721/ERC721.sol';
import '@openzeppelin/contracts/utils/Counters.sol';

import './libraries/Base64.sol';
import 'hardhat/console.sol';

contract Web3Mint is ERC721{
  struct NftAttributes{
    string name;
    string imageURL;
  }
  uint8 MAX_MINT = 50;

  NftAttributes[] Web3Nfts;

  using Counters for Counters.Counter;
  // tokenIdはNFTの一意な識別子で、0,1,2,...Nのように付与される
  Counters.Counter private _tokenIds;

  // eventnの設定
  event mintedNft(address sender, uint256 tokenId);

  constructor() ERC721('NFT', 'nft'){
    console.log('This is may NFT contract');
  }

  // ユーザーがnftを取得するために実行する関数
  function mintIpfsNFT(string memory name, string memory imageURI) public{
    uint256 newItemId = _tokenIds.current();
    if(newItemId >= MAX_MINT){
      revert('reached miting limit');
    }

    _safeMint(msg.sender, newItemId);
    Web3Nfts.push(NftAttributes({
      name: name,
      imageURL: imageURI
    }));
    console.log('An NFT /w ID %s has been minted to %s', newItemId, msg.sender);
    _tokenIds.increment();

    emit mintedNft(msg.sender, _tokenIds.current());
  }

  function tokenURI(uint256 _tokenId) public override view returns(string memory){
    string memory json = Base64.encode(
      bytes(
        string(
          abi.encodePacked(
            '{"name": "',
            Web3Nfts[_tokenId].name,
            ' -- NFT #: ',
            Strings.toString(_tokenId),
            '", "description": "An epic NFT", "image": "ipfs://',
            Web3Nfts[_tokenId].imageURL,
            '"}'
          )
        )
      )
    );

    string memory output = string(
      abi.encodePacked('data:application/json;base64,', json)
    );

    return output;
  }

  function getTotalMint()public view returns(uint256){
    uint256 totalMint = _tokenIds.current();
    return totalMint;
  }
}