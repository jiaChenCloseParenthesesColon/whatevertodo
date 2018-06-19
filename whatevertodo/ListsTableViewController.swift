//
//  ListsTableViewController.swift
//  to do list
//
//  Created by JiaChen(: on 19/6/18.
//  Copyright © 2018 SST Inc. All rights reserved.
//

import UIKit

var selected:String?

class ListsTableViewController: UITableViewController {
    
    let backgroundImage = UIImageView()
    var listContent = ["This list is empty"]
    
    func emptyCells() {
        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        
        
        backgroundImage.frame = rect
        
        if listContent.count == 0 {
            print("empty cells")
            backgroundImage.isHidden = false
            backgroundImage.sizeToFit()
            backgroundImage.contentMode = .scaleAspectFit
            backgroundImage.image = UIImage(named: "toDoEmpty.00\(Int.random(in: 1...4)).png")
            self.tableView.backgroundView = backgroundImage
        } else {
            
            backgroundImage.isHidden = true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if listTitle == "Get Started!" {
            listContent = ["Hot Chocolate", "More hot chocolate", "Even more hot chocolate", "Insulin"]
        }
        self.title = listTitle
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        tableView.tableFooterView = UIView(frame: .zero)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listContent.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        cell.accessoryType = .disclosureIndicator
        
        if UserDefaults.standard.bool(forKey: "\(listTitle!) \(listContent[indexPath.row]) isDone") == true {
            cell.detailTextLabel?.text = "You did not slack (as much as I thought)"
        } else {
            cell.detailTextLabel?.text = "You have been procrastinating slacker"
        }
        
        
        cell.textLabel?.text = listContent[indexPath.row]
        // Configure the cell...

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            listContent.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .right)
            tableView.reloadData()
            emptyCells()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
            let cellTo = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: to)
            let cellFrom = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: fromIndexPath)
            cellTo.textLabel?.text = cellFrom.textLabel?.text
            cellTo.detailTextLabel?.text = cellFrom.detailTextLabel?.text
    }
    

    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected = listContent[indexPath.row]
    }
    
    @IBAction func addNewItem(_ sender: Any) {
        let alert = UIAlertController(title: "New Task", message: nil, preferredStyle: UIAlertController.Style.alert)
        
        var textFieldText = UITextField()
        alert.addTextField { (textField) in
            textFieldText = textField
            textField.placeholder = "Task name"
        }
        
        let action = UIAlertAction(title: "Add task", style: .default) { (alertAction) in
            if !(textFieldText.text?.trimmingCharacters(in: .whitespaces).isEmpty)! {
                self.listContent.insert(textFieldText.text!, at: self.listContent.count)
                if self.listContent.count == 0 {
                    print("empty cells")
                    self.backgroundImage.isHidden = false
                    self.backgroundImage.sizeToFit()
                    self.backgroundImage.contentMode = .scaleAspectFit
                    self.backgroundImage.image = UIImage(named: "toDoEmpty.00\(Int.random(in: 1...4)).png")
                    self.tableView.backgroundView = self.backgroundImage
                } else {
                    
                    self.backgroundImage.isHidden = true
                }
                self.tableView.reloadData()
            } else {
                print("empty")
            }
        }
        
        alert.addAction(action)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
