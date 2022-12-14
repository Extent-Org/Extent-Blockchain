// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

// import "@openzeppelin/contracts/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/proxy/Clones.sol";
import "./ExtentCreator.sol";
import "./ExtentContent.sol";

struct CreatorLog {
    string username;
    ExtentCreator creatorContract;
    ExtentContent contentContract;
}

contract ExtentFactory is Ownable {
    event CreatorRegistered(
        string name,
        string username,
        string bio,
        string collectionName,
        string collectionSymbol,
        string collectionImageCID,
        ExtentContent creatorContentContract,
        ExtentCreator creatorContract
    );
    address extentCreatorImplementation;
    address extentContentImplementation;
    CreatorLog[] creatorLog;

    constructor(
        address _extentCreatorLogicAddress,
        address _extentContentLogicAddress
    ) {
        extentContentImplementation = _extentContentLogicAddress;
        extentCreatorImplementation = _extentCreatorLogicAddress;
    }

    function setExtentCreatorLogic(address _newExtentCreatorLogicAddress)
        public
        onlyOwner
    {
        extentCreatorImplementation = _newExtentCreatorLogicAddress;
    }

    function setExtentContentLogic(address _newExtentContentLogicAddress)
        public
        onlyOwner
    {
        extentContentImplementation = _newExtentContentLogicAddress;
    }

    // we need two factory functions first should be for creator and another should be for content
    function initializeCreaotor(
        string calldata _name,
        string calldata _username,
        string calldata _bio,
        string memory _collectionName,
        string memory _collectionSymbol,
        address _payOutAddress,
        string memory _collectionImageCID,
        address _creatorWhiteListAddress
    ) public {
        ExtentCreator newCreatorAddress = ExtentCreator(
            Clones.clone(extentCreatorImplementation)
        );
        ExtentContent newCreatorContentContractAddress = ExtentContent(
            Clones.clone(extentContentImplementation)
        );
        newCreatorAddress.initialize(
            _name,
            _username,
            _bio,
            _collectionName,
            _collectionSymbol,
            _payOutAddress,
            _collectionImageCID,
            newCreatorContentContractAddress
        );
        newCreatorContentContractAddress.initialize(
            newCreatorAddress,
            _creatorWhiteListAddress
        );
        creatorLog.push(
            CreatorLog(
                _username,
                newCreatorAddress,
                newCreatorContentContractAddress
            )
        );
            emit CreatorRegistered(
                _name,
                _username,
                _bio,
                _collectionName,
                _collectionSymbol,
                _collectionImageCID,
                newCreatorContentContractAddress,
                newCreatorAddress
            );
    }
}
