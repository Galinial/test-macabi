//
//  NetworkManager.swift
//  MacabiTest
//
//  Created by gal linial on 08/02/2024.
//

import Foundation

private let categoriesUrl = URL(string: "https://dummyjson.com/products?limit=100")
private let session = URLSession.shared
private let decoder = JSONDecoder()

class NetworkManager {
    
    func fetchCategoriesData(completion: @escaping (ProductsResponse?) -> Void) {
        // checking if URL isn't nil
        if let categoriesUrl = categoriesUrl {
            let dataTask = session.dataTask(with: categoriesUrl) { (data, response, error) in
                // Check for errors
                if let error = error {
                    print("Error fetching data: \(error.localizedDescription)")
                    completion(nil)
                    return
                }
                
                if let data = data {
                    do {
                        let response = try decoder.decode(ProductsResponse.self, from: data)
                        completion(response)
                    } catch {
                        print("Error decoding JSON: \(error.localizedDescription)")
                        completion(nil)
                    }
                } else {
                    print("Data is nil")
                    completion(nil)
                }
            }
            dataTask.resume()
        } else {
            print("URL is nil")
            completion(nil)
        }
    }
    
}
