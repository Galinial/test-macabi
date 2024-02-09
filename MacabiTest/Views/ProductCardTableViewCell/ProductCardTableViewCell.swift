//
//  ProductCardTableViewCell.swift
//  MacabiTest
//
//  Created by gal linial on 08/02/2024.
//

import UIKit

class ProductCardTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var stockLabel: UILabel!
    
    func populate(productDetailsModel: ProductDetailsModel) {
        self.productTitle.text = productDetailsModel.productName.capitalized
        self.priceLabel.text = "Price: \(productDetailsModel.productPrice)$"
        self.stockLabel.text = "Stock Available: \(productDetailsModel.stockQuantity)"
        self.productImageView.downloaded(from: productDetailsModel.productImageURL)
        self.productImageView.roundImage()
    }
}
