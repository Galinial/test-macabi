//
//  CategoriesOverviewViewController.swift
//  MacabiTest
//
//  Created by gal linial on 08/02/2024.
//

import UIKit

class CategoriesOverviewViewController: UIViewController {
    
    @IBOutlet weak var categoriesTableView: UITableView!
        
    private var categoriesCardModels: [CategoryCardModel] = []
    private let categoriesViewModel = CategoriesViewModel()
    
    private var selectedCategory: String? // we could have used a protocol/delegate, but this approach is simplier for this solution.
    
    private let segueToNextScreen = "goToCategoryDetails"
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        populateData()
    }
    
    //MARK: - Private Functions
    
    private func populateData() {
        categoriesViewModel.fetchAndReciveData { [weak self] categoryCardModels in
            guard let self = self else { return }
            if let categoryModels = categoryCardModels {
                self.categoriesCardModels = categoryModels
                DispatchQueue.main.async {
                    self.categoriesTableView.reloadData()
                }
            } else {
                // Handle the case where data fetch failed
                print("Failed to fetch category data")
            }
        }
    }
    
    private func setupTableView() {
        self.categoriesTableView.delegate = self
        self.categoriesTableView.dataSource = self
        
        self.categoriesTableView.register(UINib(nibName: "CategoryCardTableViewCell", bundle: nil), forCellReuseIdentifier: "categoryCellIdentifier")
    }
    
    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueToNextScreen {
            if let nextVC = segue.destination as? CategoryDetailsViewController,
            let selectedCategory {
                nextVC.productDetailsModels = categoriesViewModel.getProductsForCategory(category: selectedCategory)
            }
        }
    }
}

// MARK: - UITableView Delegate, Data Source extensions

extension CategoriesOverviewViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedCategory = categoriesCardModels[indexPath.row].categoryName
        performSegue(withIdentifier: "goToCategoryDetails", sender: nil)
    }
    
}

extension CategoriesOverviewViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categoriesCardModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCellIdentifier") as? CategoryCardTableViewCell {
            cell.populateCell(categoryCardModel: categoriesCardModels[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    
}

