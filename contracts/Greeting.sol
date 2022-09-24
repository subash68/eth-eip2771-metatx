//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/metatx/ERC2771Context.sol";
import "@openzeppelin/contracts/metatx/MinimalForwarder.sol";

contract Greeting is ERC2771Context {
    mapping (address => string ) public greetings;

    event Greeted(address indexed sender, string greeting);

    constructor(MinimalForwarder _minimalForwarder) ERC2771Context(address(_minimalForwarder)) {}

    function initialize(string memory _greeting) public {
        greetings[_msgSender()] = _greeting;
    }

    function setGreeting(string memory _greeting) public {
        greetings[_msgSender()] = _greeting;
        emit Greeted(_msgSender(), _greeting);
    }

    function getGreeting() public view returns (string memory) {
        return greetings[_msgSender()];
    }
}