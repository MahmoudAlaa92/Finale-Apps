//
//  MenuController.swift
//  Restaurant
//
//  Created by Mahmoud Alaa on 01/09/2024.
//

import Foundation

class MenuController{
    typealias MinutsToPrepare = Int
    
    enum MenuControllerError: Error, LocalizedError{
        case categriesNotFound
        case menuItemNotFound
        case orderRequestFieled
    }
    
    let baseUrl = URL(string: "http://localhost:8080/")
        
    func fetchMenuItems(forCategory categoryName: String) async throws -> [MenuItem]{
        
        let initialMenuURL = baseUrl?.appendingPathComponent("menu")
        
            var components = URLComponents(url: initialMenuURL!, resolvingAgainstBaseURL: true)
            components?.queryItems = [URLQueryItem(name: "category", value: categoryName)]

            let menuURL = components?.url
            let (data ,response) = try await URLSession.shared.data(from: menuURL!)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else{
                throw MenuControllerError.menuItemNotFound
            }
        /// Check the data is recieved successfully
//        let jsonObject = try JSONSerialization.jsonObject(with: data,options: [])
//        let dataa = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
//        if let strEncoding = String(data: dataa, encoding: .utf8){
//            print(strEncoding)
//        }
        
        do{
            let decoder = JSONDecoder()
            let menuResponse = try decoder.decode(MenuResponse.self, from: data)
            
            return menuResponse.items
        }catch{
            fatalError("Error when decoded data in fetchMenuItems function")
        }
    }
    
    func submitOrder(forMenuIDs menuIDs: [Int]) async throws -> MinutsToPrepare{
        
        let orederURL = baseUrl?.appendingPathComponent("order")
        
        /// Wrap
        var request = URLRequest(url: orederURL!)
        request.httpMethod = "POST"
        request.setValue("application/json",
                         forHTTPHeaderField: "Content-Type")
        
        let menuIdsDict = ["menuIds" : menuIDs]
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(menuIdsDict)
        
        request.httpBody = jsonData
        let (data,response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else{
            throw MenuControllerError.orderRequestFieled
        }
        
        let decoder = JSONDecoder()
        let orderResponse = try decoder.decode(OrederResponse.self, from: data)
        return orderResponse.prepTime
        
    }
    
    func fetchingCategories() async throws -> [String]{
        do{
            let categoriesURL = baseUrl?.appendingPathComponent("categories")
                
               /// wrap
                let (data ,response) = try await URLSession.shared.data(from: categoriesURL!)
                guard let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200 else{
                throw MenuControllerError.categriesNotFound
            }
            let decoder = JSONDecoder()
            let categoriesResponse = try decoder.decode(CategoriesResponse.self, from: data)
            return categoriesResponse.categories
            
        }catch {
            fatalError("Error in fetching Categories")
        }
    }
    
    
}
