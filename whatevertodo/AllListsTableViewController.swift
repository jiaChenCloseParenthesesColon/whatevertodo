//
//  AllListsTableViewController.swift
//  to do list
//
//  Created by JiaChen(: on 19/6/18.
//  Copyright © 2018 SST Inc. All rights reserved.
//

import UIKit

var listTitle: String?
var getAllItems:[String] = ["stuff"]

class AllListsTableViewController: UITableViewController {

    var tableBackground = UIImageView()
    
    var isEmpty = false
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.isHidden = isEmpty
        tableView.backgroundView?.contentMode = .scaleAspectFit
        
        //tableBackground.contentMode = .scaleAspectFit
        
        if UserDefaults.standard.array(forKey: "allLists") == nil {
            getAllItems =  ["Get Started!"]
        } else {
            getAllItems =  UserDefaults.standard.array(forKey: "allLists") as! [String]
        }
        tableView.tableFooterView = UIView(frame: .zero)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        tableView.reloadData()
    }
    // MARK: - Table view data source

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        isEmpty = true
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if getAllItems.count == 0 {
            isEmpty = true
            return 0
        } else {return getAllItems.count}
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        if isEmpty == true {
            //tableView.backgroundView = UIImageView(image: UIImage(named: "toDoEmpty.00\(Int.random(in: 1...4)).png"))
        }
        
        cell.textLabel?.text = getAllItems[indexPath.row]
        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            getAllItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .right)
            tableView.reloadData()
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let cellTo = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: to)
        let cellFrom = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: fromIndexPath)
        cellTo.textLabel?.text = cellFrom.textLabel?.text
    }
    

    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        listTitle = getAllItems[indexPath.row]
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func newCell(_ sender: Any) {
        let alert = UIAlertController(title: "New List", message: nil, preferredStyle: UIAlertController.Style.alert)
        
        var textFieldText = UITextField()
        alert.addTextField { (textField) in
            textFieldText = textField
            textField.placeholder = "List name"
        }
        
        let action = UIAlertAction(title: "Add list", style: .default) { (alertAction) in
            if !(textFieldText.text?.trimmingCharacters(in: .whitespaces).isEmpty)! {
                getAllItems.insert(textFieldText.text!, at: getAllItems.count)
                self.tableView.reloadData()
            } else {
                print("empty")
            }
        }
        
        alert.addAction(action)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
}
