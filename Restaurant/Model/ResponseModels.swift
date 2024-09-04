//
//  ResponseModels.swift
//  Restaurant
//
//  Created by Mahmoud Alaa on 01/09/2024.
//

import UIKit

struct MenuResponse: Codable{
    let items: [MenuItem]
}

struct CategoriesResponse: Codable{
    let categories: [String]
}


struct OrederResponse: Codable{
    let prepTime: Int
    
    enum CodingKeys: String, CodingKey{
            case prepTime = "preparation_time"
    }
}


