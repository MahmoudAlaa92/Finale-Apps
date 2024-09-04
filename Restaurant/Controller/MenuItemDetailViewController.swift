//
//  MenuItemDetailViewController.swift
//  Restaurant
//
//  Created by Mahmoud Alaa on 01/09/2024.
//

import UIKit

class MenuItemDetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addToOrderBtn: UIButton!
    @IBOutlet weak var detailTextLabel: UILabel!
    
    var menuItem: MenuItem = MenuItem(id: 0, name: "", detailText: "", price: 0.0, category: "", imageURL: URL(string: "http://localhost:8080/")!)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updataUI()
    }

    // Updata UI
    func updataUI(){
        nameLabel.text = menuItem.name
        priceLabel.text = menuItem.price.formatted(.currency(code: "usd"))
        detailTextLabel.text = menuItem.detailText
        
    }
    
    @IBAction func orderButtonTapped(_ sender: Any) {
        
        UIView.animate(withDuration: 0.5,delay: 0 ,usingSpringWithDamping: 0.7 ,initialSpringVelocity: 0.1, options: []) {
            self.addToOrderBtn.transform = CGAffineTransform(scaleX: 2, y: 2)
            self.addToOrderBtn.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
    
}

