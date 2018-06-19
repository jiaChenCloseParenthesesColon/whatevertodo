//
//  DetailTableViewController.swift
//  to do list
//
//  Created by JiaChen(: on 19/6/18.
//  Copyright © 2018 SST Inc. All rights reserved.
//

import UIKit
import SafariServices

class DetailTableViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var markAsDone: UILabel!
    @IBOutlet weak var informationLink: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = selected
        
        if UserDefaults.standard.bool(forKey: "\(listTitle!) \(selected!) isDone") == false {
            markAsDone.text = "Mark as done"
        } else {
            markAsDone.text = "It's not done!"
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath == IndexPath.init(row: 0, section: 3) {
            print("yay")
            if UserDefaults.standard.bool(forKey: "\(listTitle!) \(selected!) isDone") == false {
                UserDefaults.standard.set(true, forKey: "\(listTitle!) \(selected!) isDone")
                tableView.deselectRow(at: indexPath, animated: true)
                navigationController?.popViewController(animated: true)
            } else {
                UserDefaults.standard.set(false, forKey: "\(listTitle!) \(selected!) isDone")
                tableView.deselectRow(at: indexPath, animated: true)
                navigationController?.popViewController(animated: true)
            }
            
            
        }
    }
    
    @IBAction func tappedLink(_ sender: Any) {
        if !(informationLink.text?.trimmingCharacters(in: .whitespaces).isEmpty)! {
            let s = SFSafariViewController(url: URL(string: (informationLink.text?.trimmingCharacters(in: .whitespaces))!)!)
            self.present(s, animated: true, completion: nil)
        }
    }
}
