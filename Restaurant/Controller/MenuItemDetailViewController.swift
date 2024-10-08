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
    
    var menuItem: MenuItem = MenuItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updataUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        MenuController.shared.updataUserActivity(with: .menuItemDetail(menuItem))
    }
    
    // Updata UI
    func updataUI(){
        nameLabel.text = menuItem.name
        priceLabel.text = menuItem.price.formatted(.currency(code: "usd"))
        detailTextLabel.text = menuItem.detailText
        
        Task.init{
            if let image = try? await MenuController.shared.fetchImage(from: menuItem.imageURL!){
                imageView.image = image
            }
        }
    }
    
    @IBAction func orderButtonTapped(_ sender: Any) {
        
        UIView.animate(withDuration: 0.5,delay: 0 ,usingSpringWithDamping: 0.7 ,initialSpringVelocity: 0.1, options: []) {
            self.addToOrderBtn.transform = CGAffineTransform(scaleX: 2, y: 2)
            self.addToOrderBtn.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
        MenuController.shared.order.menuItems.append(menuItem)
    }
    
}

