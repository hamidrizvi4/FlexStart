const anticounterfeit = artifacts.require("anticounterfeit.sol");

module.exports = function(deployer) {
    deployer.deploy(anticounterfeit);
};