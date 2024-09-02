//
//  Order.swift
//  Restaurant
//
//  Created by Mahmoud Alaa on 01/09/2024.
//

import Foundation

struct Order: Codable{
    var menuItems: [MenuItem]
    
    init(menuItems: [MenuItem]) {
        self.menuItems = menuItems
    }
}
