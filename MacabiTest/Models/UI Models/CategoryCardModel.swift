//
//  CategoryCardModel.swift
//  MacabiTest
//
//  Created by gal linial on 08/02/2024.
//

import Foundation

/*
 Category Card Details:
 For each category, create a card that displays:
 The category name.
 The thumbnail of the first product in that category.
 The total number of distinct products in the category.
 The total sum of all products in stock for that category.
 */

class CategoryCardModel {
    let categoryName: String
    let firstProductImageURL: String
    let numberOfProductsForCategory: Int
    let sumOfAllProductsInStockForCategory: Int
    
    init(categoryName: String, firstProductImageURL: String, numberOfPruductsForCategory: Int, sumOfAllProductsInStockForCategory: Int) {
        self.categoryName = categoryName
        self.firstProductImageURL = firstProductImageURL
        self.numberOfProductsForCategory = numberOfPruductsForCategory
        self.sumOfAllProductsInStockForCategory = sumOfAllProductsInStockForCategory
    }
}
