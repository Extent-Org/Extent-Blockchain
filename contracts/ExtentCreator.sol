// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

// import "@oopenzeppelin-contracts/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./CreatorCollection.sol";
import "./ExtentContent.sol";

contract ExtentCreator is Ownable {
    string name;
    string username;
    string bio;
    string[] domains;
    string collectionName;
    string collectionImageCID;
    string secretKey; //discussionable
    address earningAddress;
    string collectionSymbol;
    ExtentContent contentContractAddress;
    CreatorCollection collectionAddress;

    function initialize(
        string memory _name, 
        string memory _username, 
        string memory _bio, 
        string[] memory _domains, 
        string calldata _collectionName, 
        string calldata _collectionSymbol, 
        address _payOutAddress,  
        string calldata _collectionImageCID,
        ExtentContent _contentContractAddress) public {
            name = _name;
            username = _username;
            bio = _bio;
            domains = _domains;
            collectionName = _collectionName;
            collectionSymbol = _collectionSymbol;
            earningAddress = _payOutAddress;
            collectionImageCID = _collectionImageCID;
            CreatorCollection _creatorNFTCollectionContract = new CreatorCollection(_collectionName, _collectionSymbol);
            collectionAddress = _creatorNFTCollectionContract;
            contentContractAddress = _contentContractAddress;
        }        
}