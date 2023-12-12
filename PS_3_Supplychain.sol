// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PS_3_SupplyChain {
    enum Role { Manufacturer, Distributor, Retailer }
    
    struct Product {
        uint256 productId;
        string productName;
        string date_of_manufacturing; 
        string location; 
        address owner;
        Role currentRole;
    }

    mapping(uint256 => Product)  products;
    uint256 public total_no_Products;

    constructor() {
        total_no_Products = 0;
    }

    function createProduct(
        uint256 productId,
        string memory productName,
        string memory date_of_manufacturing,
        string memory location
    ) public {
        require(products[productId].productId == 0, "Product with this ID already exists");

        products[productId] = Product({
            productId: productId,
            productName: productName,
            date_of_manufacturing: date_of_manufacturing,
            location: location,
            owner: msg.sender,
            currentRole: Role.Manufacturer
        });

        total_no_Products++;
    }

    function shipProduct(uint256 productId) public {
        require(products[productId].owner == msg.sender, "Only the owner can ship the product");
        
        if (products[productId].currentRole == Role.Manufacturer) {
            products[productId].currentRole = Role.Distributor;
        } else if (products[productId].currentRole == Role.Distributor) {
            products[productId].currentRole = Role.Retailer;
        } else {
            revert("Product cannot be shipped further");
        }
    }

    function getCurrentStatus(uint256 productId) public view returns (string memory) {
        
        if (products[productId].currentRole == Role.Manufacturer) {
            return "Manufacturer has the product";
        } else if (products[productId].currentRole == Role.Distributor) {
            return "Distributor has the product";
        } else if (products[productId].currentRole == Role.Retailer) {
            return "Retailer has the product";
        } else {
            return "We have no idea where the product is ! ";
        }
    }
}
