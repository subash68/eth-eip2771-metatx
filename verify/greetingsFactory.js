const { Greeting, MinimalForwarder } = require("../deployments/deploy.json");

const args = {
  _implementation: Greeting,
  _minimalForwarder: MinimalForwarder,
};

module.exports = [args._implementation, args._minimalForwarder];
