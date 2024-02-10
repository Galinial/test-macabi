//
//  CategoryDetailsViewController.swift
//  MacabiTest
//
//  Created by gal linial on 08/02/2024.
//

import UIKit

class CategoryDetailsViewController: UIViewController {
    
    @IBOutlet weak var categoryDetailsTableView: UITableView!
    var productDetailsModels: [ProductDetailsModel]?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        categoryDetailsTableView.dataSource = self
        categoryDetailsTableView.register(UINib(nibName: "ProductCardTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductCardIdentifier")
    }

}

extension CategoryDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let productDetailsModels {
            return productDetailsModels.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCardIdentifier") as? ProductCardTableViewCell,
            let productDetailsModels {
            cell.populate(productDetailsModel: productDetailsModels[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
}
