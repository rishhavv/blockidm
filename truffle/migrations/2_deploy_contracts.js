const Hello=artifacts.require("../contracts/Hello.sol");

module.exports = function (deployer) {
   deployer.deploy(Hello);
};