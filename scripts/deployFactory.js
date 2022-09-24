const {
  DefenderRelayProvider,
  DefenderRelaySigner,
} = require("defender-relay-client/lib/ethers");
const { ethers } = require("hardhat");
const { writeFileSync } = require("fs");
const { Greeting, MinimalForwarder } = require("../deployments/deploy.json");

async function main() {
  require("dotenv").config();
  const credentials = {
    apiKey: process.env.RELAYER_API_KEY,
    apiSecret: process.env.RELAYER_API_SECRET,
  };

  const provider = new DefenderRelayProvider(credentials);
  const relaySigner = new DefenderRelaySigner(credentials, provider, {
    speed: "fast",
  });

  // deploy contract
  const GreetingFactory = await ethers.getContractFactory("GreetingFactory");
  const factory = await GreetingFactory.connect(relaySigner)
    .deploy(Greeting, MinimalForwarder)
    .then((f) => f.deployed());

  writeFileSync(
    "deployments/deployFactory.json",
    JSON.stringify(
      {
        GreetingFactory: factory.address,
        MinimalForwarder: MinimalForwarder,
      },
      null,
      2
    )
  );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
