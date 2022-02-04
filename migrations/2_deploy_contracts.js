// const Decentragram = artifacts.require("Decentragram");
//
// module.exports = function(deployer) {
//   deployer.deploy(Decentragram);
//
// };

var Decentragram = artifacts.require("Decentragram");

module.exports = function(deployer){
  deployer.deploy(Decentragram);
}
