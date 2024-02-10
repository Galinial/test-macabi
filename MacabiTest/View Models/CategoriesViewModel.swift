//
//  CategoriesViewModel.swift
//  MacabiTest
//
//  Created by gal linial on 08/02/2024.
//

import Combine
import Foundation

class CategoriesViewModel {
    private var dataManager = DataManager()
    private var categories: [Product] = []

    func fetchAndReciveData(completion: @escaping ([CategoryCardModel]?) -> Void) {
        dataManager.fetchCategoriesData { [weak self] response in
            guard let self = self else { return }
            if let response = response {
                self.categories = response.products
                let models = self.createAndReturnCategoryCardModels()
                completion(models)
            } else {
                completion(nil)
            }
        }
    }
    
    //MARK: - CategoryOverview

    private func createAndReturnCategoryCardModels() -> [CategoryCardModel] {
        var categoriesCardModelArray: [CategoryCardModel] = []
        
        var duplicationValidationArr: [String] = [] // Each category should be represented only once.
        var totalDistinctProductsForCategoryDict: [String: Int] = [:] // The total number of distinct products in the category.
        var totalSumForPruductsCategoryInStockDict: [String: Int] = [:] // The total sum of all products in stock for that category.

        for category in categories {
            totalDistinctProductsForCategoryDict[category.category, default: 0] += 1
            totalSumForPruductsCategoryInStockDict[category.category, default: 0] += category.stock
        }

        for category in categories {
            if !duplicationValidationArr.contains(category.category) {
                duplicationValidationArr.append(category.category)
                let newModel = CategoryCardModel(categoryName: category.category, firstProductImageURL: category.thumbnail, numberOfPruductsForCategory: totalDistinctProductsForCategoryDict[category.category] ?? 0, sumOfAllProductsInStockForCategory: totalSumForPruductsCategoryInStockDict[category.category] ?? 0)
                categoriesCardModelArray.append(newModel)
            }
        }
        return categoriesCardModelArray
    }
    
    //MARK: - CategoryDetails
    
    func getProductsForCategory(category: String) -> [ProductDetailsModel] {
        
        let selectedCatagoryProducts = categories.filter({ $0.category == category })
        var productsToReturn: [ProductDetailsModel] = []
        
        for product in selectedCatagoryProducts {
            let productDetailsModel = ProductDetailsModel(productName: product.title, productImageURL: product.thumbnail, productPrice: product.price, stockQuantity: product.stock)
            productsToReturn.append(productDetailsModel)
        }
        
        return productsToReturn
    }
}
