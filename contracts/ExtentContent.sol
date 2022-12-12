// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

// import "@oopenzeppelin-contracts/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./ExtentCreator.sol";

struct Video {
    string name;
    string description;
    string videoCID;
    string mimeType;
}

struct Image {
    string name;
    string description;
    string imageCID;
    string mimeType;
}

struct Song {
    string name;
    string description;
    string songCID;
    string mimeType;
}

contract ExtentContent is Ownable {
    ExtentCreator contentOwner;
    address creatorWhiteListedAddress;
    Song[] songContent;
    Image[] imageContent;
    Video[] videoContent;

    modifier onlyCreator(address _creatorAddress) {
        require(_creatorAddress == creatorWhiteListedAddress);
        _;
    }

    function stringsEquals(string memory s1, string memory s2)
        private
        pure
        returns (bool)
    {
        bytes memory b1 = bytes(s1);
        bytes memory b2 = bytes(s2);
        uint256 l1 = b1.length;
        if (l1 != b2.length) return false;

        for (uint256 i = 0; i < l1; i++) {
            if (b1[i] != b2[i]) return false;
        }
        return true;
    }

    function initialize(
        ExtentCreator _creatorAddress,
        address _creatorWhiteListedAddress
    ) public onlyOwner {
        contentOwner = _creatorAddress;
        creatorWhiteListedAddress = _creatorWhiteListedAddress;
    }

    function addSongContent(
        string calldata _name,
        string calldata _description,
        string calldata _cid,
        string calldata _mimetype
    ) public onlyCreator(msg.sender) {
        Song memory _newSong = Song(_name, _description, _cid, _mimetype);
        songContent.push(_newSong);
    }

    function addVideoContent(
        string calldata _name,
        string calldata _description,
        string calldata _cid,
        string calldata _mimetype
    ) public onlyCreator(msg.sender) {
        Video memory _newVideo = Video(_name, _description, _cid, _mimetype);
        videoContent.push(_newVideo);
    }

    function addImageContent(
        string calldata _name,
        string calldata _description,
        string calldata _cid,
        string calldata _mimetype
    ) public onlyCreator(msg.sender) {
        Image memory _newImage = Image(_name, _description, _cid, _mimetype);
        imageContent.push(_newImage);
    }

    function removeSong(uint256 _contentIndex) private {
        // overwriting the current content
        for (uint256 i = _contentIndex; i < songContent.length - 1; i++) {
            songContent[i] = songContent[i + 1];
        }
        // removing the last redundant entry
        songContent.pop();
    }

    function removeVideo(uint256 _contentIndex) private {
        // overwriting the current content
        for (uint256 i = _contentIndex; i < videoContent.length - 1; i++) {
            videoContent[i] = videoContent[i + 1];
        }
        // removing the last redundant entry
        videoContent.pop();
    }

    function removeImg(uint256 _contentIndex) private {
        // overwriting the current content
        for (uint256 i = _contentIndex; i < imageContent.length - 1; i++) {
            imageContent[i] = imageContent[i + 1];
        }
        // removing the last redundant entry
        imageContent.pop();
    }

    function removeSongContent(
        string calldata _cid,
        string calldata _contentType
    ) public onlyCreator(msg.sender) {
        uint256 _contentIndex;

        if (stringsEquals(_contentType, "song")) {
            for (uint256 i = 0; i < songContent.length; i++) {
                if (stringsEquals(songContent[i].songCID, _cid)) {
                    _contentIndex = i;
                }
            }
            removeSong(_contentIndex);
        } else if (stringsEquals(_contentType, "video")) {
            for (uint256 i = 0; i < videoContent.length; i++) {
                if (stringsEquals(videoContent[i].videoCID, _cid)) {
                    _contentIndex = i;
                }
            }
            removeVideo(_contentIndex);
        } else if (stringsEquals(_contentType, "img")) {
            for (uint256 i = 0; i < imageContent.length; i++) {
                if (stringsEquals(imageContent[i].imageCID, _cid)) {
                    _contentIndex = i;
                }
            }
            removeImg(_contentIndex);
        }
    }

    function getSongs() public returns (Song[] memory) {
        return songContent;
    }

    function getVideos() public returns (Video[] memory) {
        return videoContent;
    }

    function getImage() public returns (Image[] memory) {
        return imageContent;
    }
}
