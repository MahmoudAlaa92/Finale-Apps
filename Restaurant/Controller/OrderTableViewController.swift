//
//  OrderTableViewController.swift
//  Restaurant
//
//  Created by Mahmoud Alaa on 04/09/2024.
//

import UIKit

class OrderTableViewController: UITableViewController {
    
    var minutsToPrepareOrder = 0
    var imageLoadTasks: [IndexPath: Task<Void, Never>] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageLoadTasks.forEach { key, value in
            value.cancel()
        }
        
        navigationItem.leftBarButtonItem = editButtonItem
        
        NotificationCenter.default.addObserver(tableView!, selector: #selector(UITableView.reloadData), name: MenuController.orderUpdatedNotification, object: nil)
    }

    // Submit button
    @IBAction func submitTapped(_ sender: Any) {
    let orderTotal = MenuController.shared.order.menuItems.reduce(0.0){
            (result, menuItem) -> Double in
            return result + menuItem.price
        }
        
        let formmatedTotal = orderTotal.formatted(.currency(code: "usd"))
        // alert
        let alertController = UIAlertController(
            title: "Confirm Order",
            message: "You are about to submit your order with a total of \(formmatedTotal)",
            preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(
            title: "submit",
            style: .default,
            handler: { _ in
                self.uploudOrder()
            }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alertController, animated: true)
    }
    
    // Uploud order
    func uploudOrder(){
        
        let menuIds = MenuController.shared.order.menuItems.map { $0.id }
        
        Task.init{
            do{
                let minutesToPrepare = try await MenuController.shared.submitOrder(forMenuIDs: menuIds)
                minutsToPrepareOrder = minutesToPrepare
                performSegue(withIdentifier: "confirmOrder", sender: nil)
            }catch let error{
                displayError(error, title: "Order Sumbmission Failed")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "confirmOrder",
           let confirmationVc = segue.destination as? OrderConfirmationViewController{
            confirmationVc.minutsToPrepare = minutsToPrepareOrder
        }

    }
    
    // Display error
    func displayError(_ error: Error ,title: String){
        guard let _ = viewIfLoaded?.window else{ return }
        
        let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
        self.present(alert, animated: true)
    }
    
    // Unwind segue
    @IBAction func unwindToOrderList(segue: UIStoryboardSegue){
        if segue.identifier == "dismissConfirmation"{
            MenuController.shared.order.menuItems.removeAll()
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return MenuController.shared.order.menuItems.count
    }

    // Cell for row at
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Order", for: indexPath)
        	configure(cell, forItemAt: indexPath)
        
        return cell
    }
    
    // Configure cell
    func configure(_ cell:UITableViewCell, forItemAt indexPath: IndexPath){
        
        guard let cell = cell as? MenuItemCell else { return }
        
        let menuItem = MenuController.shared.order.menuItems[indexPath.row]
     
        cell.itemName = menuItem.name
        cell.price = menuItem.price
        
        imageLoadTasks [indexPath] = Task.init{
            if let image = try? await MenuController.shared.fetchImage(from: menuItem.imageURL!){
                
                if let currentIndexPath = self.tableView.indexPath(for: cell),
                   currentIndexPath == indexPath{
                    cell.image = image
                }
            }
        }
        imageLoadTasks[indexPath] = nil
    }

    // Can edit row at
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Commit
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            MenuController.shared.order.menuItems.remove(at: indexPath.row)
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
