//
//  ProductDetailsModel.swift
//  MacabiTest
//
//  Created by gal linial on 08/02/2024.
//

import Foundation

/*
 Product Item Details:
 Each product item in the list should display:
 The product's name.
 The product's image.
 The product's price.
 The available stock quantity.
 */

class ProductDetailsModel {
    let productName: String
    let productImageURL: String
    let productPrice: Double
    let stockQuantity: Int
    
    init(productName: String, productImageURL: String, productPrice: Double, stockQuantity: Int) {
        self.productName = productName
        self.productImageURL = productImageURL
        self.productPrice = productPrice
        self.stockQuantity = stockQuantity
    }
}
