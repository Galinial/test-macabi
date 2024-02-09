//
//  CategoriesViewModel.swift
//  MacabiTest
//
//  Created by gal linial on 08/02/2024.
//

import Combine
import Foundation

class CategoriesViewModel {
    private var networkManager = NetworkManager()
    private var categories: [Product] = []

    func fetchAndReciveData(completion: @escaping ([CategoryCardModel]?) -> Void) {
        networkManager.fetchCategoriesData { [weak self] response in
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

    private func createAndReturnCategoryCardModels() -> [CategoryCardModel] {
        var dictForValidateDuplicates: [String] = []
        var categoriesCardModelArray: [CategoryCardModel] = []
        var numberOfpruductsForEachCategory: [String: Int] = [:]
        var totalSumForPruductInStock: [String: Int] = [:]

        for category in categories {
            numberOfpruductsForEachCategory[category.category, default: 0] += 1
            totalSumForPruductInStock[category.category, default: 0] += category.stock
        }

        for category in categories {
            if !dictForValidateDuplicates.contains(category.category) {
                dictForValidateDuplicates.append(category.category)
                let newModel = CategoryCardModel(categoryName: category.category, firstProductImageURL: category.thumbnail, numberOfPruductsForCategory: numberOfpruductsForEachCategory[category.category] ?? 0, sumOfAllProductsInStockForCategory: totalSumForPruductInStock[category.category] ?? 0)
                categoriesCardModelArray.append(newModel)
            }
        }
        return categoriesCardModelArray
    }
    
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
