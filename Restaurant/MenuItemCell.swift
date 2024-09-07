//
//  MenuItemCell.swift
//  Restaurant
//
//  Created by Mahmoud Alaa on 06/09/2024.
//

import UIKit

class MenuItemCell: UITableViewCell{
    
    var itemName: String? = nil {
        didSet{
            if oldValue != itemName{
                setNeedsUpdateConfiguration()
            }
        }
    }
    
    var price: Double? = nil{
        didSet{
            if oldValue != price{
                setNeedsUpdateConfiguration()
            }
        }
    }
    
    var image: UIImage? = nil{
        didSet{
            if oldValue != image{
                setNeedsUpdateConfiguration()
            }
        }
    }
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        var content = defaultContentConfiguration()
        content.text = itemName
        content.secondaryText = price?.formatted(.currency(code: "usd"))
        content.prefersSideBySideTextAndSecondaryText = true
        content.imageProperties.maximumSize = CGSize(width: 55, height: 55)
        content.imageProperties.reservedLayoutSize = CGSize(width: 55, height: 55)
        
        if let image = image{
            content.image = image
        }else{
            content.image = UIImage(systemName: "photo.on.rectangle")
        }
        
        self.contentConfiguration = content
    }
    
}
