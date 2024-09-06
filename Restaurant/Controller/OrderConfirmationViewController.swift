//
//  OrderConfirmationViewController.swift
//  Restaurant
//
//  Created by Mahmoud Alaa on 06/09/2024.
//

import UIKit

class OrderConfirmationViewController: UIViewController {

    var minutsToPrepare: Int = 0
    
    @IBOutlet weak var confirmationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        confirmationLabel.text = "Thank you for your order! Your wait time is approximately \(minutsToPrepare) minutes"
        
    }
    

}
