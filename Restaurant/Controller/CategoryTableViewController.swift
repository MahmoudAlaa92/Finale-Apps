//
//  CategoryTableViewController.swift
//  Restaurant
//
//  Created by Mahmoud Alaa on 01/09/2024.
//

import UIKit

class CategoryTableViewController: UITableViewController {

    var categories = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Task.init{
            do{
                let categories = try await MenuController.shared.fetchingCategories()
                updateUI(with: categories)
            }catch{
                displayError(error, title: "Failed to Fetch Categories")
            }
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        MenuController.shared.updataUserActivity(with: .categories)
    }
    
    // Update UI
    func updateUI(with categories: [String]){
        self.categories = categories
        self.tableView.reloadData()
    }
    
    // Display Error
    func displayError(_ error: Error, title: String){
        guard let _ = viewIfLoaded?.window else { return }
        
        let alert = UIAlertController(
            title: title,
            message: error.localizedDescription,
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
        self.present(alert, animated: true)
    }
    
   // Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMenu",
           let menuVC = segue.destination as? MenuTableViewController,
           let indexPath = tableView.indexPathForSelectedRow {
           let category = categories[indexPath.row]
            menuVC.category = category
        }
    }
    


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categories.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Category", for: indexPath)
        configerCell(cell, forCategoryAt: indexPath)

        return cell
    }
    
    func configerCell(_ cell: UITableViewCell, forCategoryAt indexPath: IndexPath){
        let category = categories[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = category.capitalized
        cell.contentConfiguration = content
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
