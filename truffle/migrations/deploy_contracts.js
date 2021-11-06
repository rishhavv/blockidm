const Hello=artifacts.require("truffle/contracts/hello.sol");

module.exports = function (deployer) {
   deployer.deploy(Hello);
};