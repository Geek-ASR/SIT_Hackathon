// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DigitalArtOwnership {
    address owner;

    struct Artwork {
        address artist;
        string artist_name;
        address currentOwner;
        bool Keep_Record;
    }

    mapping(uint256 => Artwork) artworks;

    constructor() {
        owner = msg.sender;
    }

    function registerArtwork(uint256 art_no, string memory artist_name) public {
        require(!artworks[art_no].Keep_Record, "Artwork is already registered");
        
        Artwork memory newArtwork = Artwork({
            artist: msg.sender,
            artist_name: artist_name,
            currentOwner: msg.sender,
            Keep_Record: true
        });

        artworks[art_no] = newArtwork;
    }

    function transferArtwork(uint256 art_no, address newOwner, string memory new_owner_name) public {
        require(artworks[art_no].Keep_Record, "Artwork is not registered");
        require(artworks[art_no].currentOwner == msg.sender, "You are not the owner of the artwork so you cant transfer it !");

        artworks[art_no].currentOwner = newOwner;
        artworks[art_no].artist_name = new_owner_name;
    }

    function getArtworkOwner(uint256 art_no) public view returns (address, string memory) {
        require(artworks[art_no].Keep_Record, "Artwork is not registered");
        return (artworks[art_no].currentOwner, artworks[art_no].artist_name);
    }
}
