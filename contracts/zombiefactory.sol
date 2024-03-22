// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import "./ownable.sol";
import "./safemath.sol";

contract ZombieFactory is Ownable {

  using SafeMath for uint256;

  event NewZombie(uint zombieId, string name, uint dna);

  uint dnaDigits = 16;
  uint dnaModulus = 10 ** dnaDigits;
  uint cooldownTime = 1 days;

  struct Zombie {
    string name;
    uint dna;
    uint32 level;
    uint32 readyTime;
    uint16 winCount;
    uint16 lossCount;
  }

  Zombie[] public zombies;

  mapping (uint => address) public zombieToOwner;
  mapping (address => uint) ownerZombieCount;
    
  function _createZombie(string memory _name, uint256 _dna) internal {
    uint256 id = zombies.length;
    zombies.push(Zombie(_name, _dna, 1, uint32(block.timestamp + cooldownTime), 0, 0));
    zombieToOwner[id] = msg.sender;
    ownerZombieCount[msg.sender]++;
    emit NewZombie(id, _name, _dna);
  }

  function generateRandomDna(string memory _str) private view returns (uint256) {
    uint256 rand = uint256(keccak256(abi.encodePacked(_str)));
    return rand % dnaModulus;
  }

  function createRandomZombie(string memory _name) public {
    require(ownerZombieCount[msg.sender] == 0, "You already own a zombie.");
    uint256 randDna = generateRandomDna(_name);
    randDna = randDna - randDna % 100;
    _createZombie(_name, randDna);
  }
}
