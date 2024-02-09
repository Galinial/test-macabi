//
//  CategoryCardTableViewCell.swift
//  MacabiTest
//
//  Created by gal linial on 08/02/2024.
//

import UIKit

class CategoryCardTableViewCell: UITableViewCell {
    
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var distinctProducts: UILabel!
    @IBOutlet weak var productsInStock: UILabel!
    @IBOutlet weak var categoryImageView: UIImageView!
    
    func populateCell(categoryCardModel: CategoryCardModel) {
        self.categoryName.text = categoryCardModel.categoryName.capitalized
        self.distinctProducts.text = "Distinct products: \(categoryCardModel.numberOfProductsForCategory)"
        self.productsInStock.text = "in stock: \(categoryCardModel.sumOfAllProductsInStockForCategory)"
        self.categoryImageView.downloaded(from: categoryCardModel.firstProductImageURL)
    }
    
}
