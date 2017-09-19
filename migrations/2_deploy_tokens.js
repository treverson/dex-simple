const FirstToken = artifacts.require(`./FirstToken.sol`)
const SecondToken = artifacts.require(`./SecondToken.sol`)
const Exchange = artifacts.require(`./Exchange.sol`)

module.exports = (deployer) => {
  deployer.deploy(FirstToken)
  deployer.deploy(SecondToken)
  deployer.deploy(Exchange)
}
