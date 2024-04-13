//
//  ItemViewModel.swift
//  Hungry2Grow
//
//  Created by Vedant Patil on 12/04/24.
//

import Foundation
import SwiftUI

class ItemViewModel: ObservableObject {
    @Published var items: [Item] = []
    @Published var errorMessage: String?

    func fetchItems() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            self.errorMessage = "Invalid URL😔"
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    // Handle network errors
                    print("Network Error: \(error.localizedDescription)")
                    self.errorMessage = "Network Error: \(error.localizedDescription)😔"
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    // Handle invalid response
                    print("Invalid HTTP Response")
                    self.errorMessage = "Invalid HTTP Response😔"
                    return
                }
                
                guard (200...299).contains(httpResponse.statusCode) else {
                    // Handle HTTP errors
                    print("HTTP Error: \(httpResponse.statusCode)")
                    self.errorMessage = "HTTP Error: \(httpResponse.statusCode)😔"
                    return
                }
                
                guard let data = data else {
                    // Handle no data received
                    print("No data received")
                    self.errorMessage = "No data received😔"
                    return
                }
                
                do {
                    self.items = try JSONDecoder().decode([Item].self, from: data)
                    self.errorMessage = nil
                } catch {
                    // Handle parsing errors
                    print("JSON Parsing Error: \(error.localizedDescription)")
                    self.errorMessage = "JSON Parsing Error: \(error.localizedDescription)"
                }
            }
        }.resume()
    }

    
}
