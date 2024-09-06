//
//  MenuItem.swift
//  Restaurant
//
//  Created by Mahmoud Alaa on 01/09/2024.
//

import Foundation

struct MenuItem: Codable{
    var id: Int = 1
    var name: String = ""
    var detailText: String = ""
    var price: Double = 0.0
    var category: String = ""
    var imageURL: URL? = URL(string: "")
    
    enum CodingKeys: String, CodingKey{
        case id
        case name
        case detailText = "description"
        case price
        case category
        case imageURL = "image_url"
    }
}
