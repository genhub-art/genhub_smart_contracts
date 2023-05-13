# Smart Contracts for http://genhub.art/

Using hardhat to build, generate abis and deploy.

/contacts/collection.sol - ERC721 NFT collection for minting of generative NFTs. Takes a small fee.

/contracts/factory.sol - Factory smart contract which deploys and keeps track of all collections.


/data/abi/Collection.json and /data/abi/CollectionFactory.json - relevant smart contract abis


/scripts/deploy.ts - deployment script

Requires secrets.json

```
{
  "priv": "...",
  "bscscanApiKey": "..."
}
```

```
npm install
```

```
npx hardhat export-abi
```

```
npx hardhat run --network testnet scripts/deploy.ts
```
