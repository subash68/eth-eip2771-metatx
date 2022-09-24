//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/metatx/ERC2771Context.sol";
import "@openzeppelin/contracts/metatx/MinimalForwarder.sol";
import "@openzeppelin/contracts/proxy/Clones.sol";
import "../Greeting.sol";

contract GreetingFactory is ERC2771Context {
    address public implemenentationContract;
   
    event NewClone(address _clone);

    constructor(address _implementation, MinimalForwarder _minimalForwarder) ERC2771Context(address(_minimalForwarder)) {
        implemenentationContract = _implementation;
    }

    function cloneContract(string memory _greeting) external returns(address instance) {
        instance = Clones.clone(implemenentationContract);
        Greeting(instance).initialize(_greeting);
        emit NewClone(instance);
        return instance;
    }
}