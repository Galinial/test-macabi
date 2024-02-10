//
//  DataManager.swift
//  MacabiTest
//
//  Created by gal linial on 08/02/2024.
//

import Foundation

private let categoriesUrl = URL(string: "https://dummyjson.com/products?limit=100")
private let session = URLSession.shared
private let decoder = JSONDecoder()
private let cacheFileName = "CategoriesJSONData"

class DataManager {
    
    func fetchCategoriesData(completion: @escaping (ProductsResponse?) -> Void) {
        // Check if the file is already cached
        if let jsonData = loadJSONDataFromFile(filename: cacheFileName) {
            do {
                let response = try decoder.decode(ProductsResponse.self, from: jsonData)
                completion(response)
                return
            } catch {
                print("Error fetching JSON Data from cache file \(error.localizedDescription)")
            }
        }
        
        // Checking if URL isn't nil
        if let categoriesUrl = categoriesUrl {
            let dataTask = session.dataTask(with: categoriesUrl) { [weak self] (data, response, error) in
                // Check for errors
                if let error = error {
                    print("Error fetching data: \(error.localizedDescription)")
                    completion(nil)
                    return
                }
                
                if let data = data {
                    do {
                        // Cache the JSON File
                        self?.cacheJSONData(jsonData: data)
                        
                        // Return the Object in completion
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
    
    // Cache JSON Data
    private func cacheJSONData(jsonData: Data) {
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory,
                                                            in: .userDomainMask).first {
            let pathWithFileName = documentDirectory.appendingPathComponent(cacheFileName)
            do {
                try jsonData.write(to: pathWithFileName)
            } catch {
                print("Failed to Save")
            }
        }
    }
    
    // Load JSON data
    private func loadJSONDataFromFile(filename: String) -> Data? {
        // Get the document directory
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            // Append the filename to the document directory
            let fileURL = documentDirectory.appendingPathComponent(filename)
            
            // Read data from the file
            do {
                let jsonData = try Data(contentsOf: fileURL)
                return jsonData
            } catch {
                print("Error reading JSON data from file:", error)
                return nil
            }
        } else {
            print("Error getting document directory.")
            return nil
        }
    }
    
}


