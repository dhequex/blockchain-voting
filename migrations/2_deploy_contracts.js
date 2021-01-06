var Voting = artifacts.require("./Voting.sol");
var SimpleStorage = artifacts.require("./SimpleStorage.sol")

module.exports = function(deployer) {
  deployer.deploy(Voting);
  deployer.deploy(SimpleStorage);
};
