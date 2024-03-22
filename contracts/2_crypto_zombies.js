var CryptoZombies = artifacts.require("./CryptoZombies.sol");

export default function(deployer){
    deployer.deploy(CryptoZombies);
}
