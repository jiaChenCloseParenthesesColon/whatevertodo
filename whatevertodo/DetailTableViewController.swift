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
    @IBOutlet weak var remindMeOrNot: UISwitch!
    @IBOutlet weak var excusesTextView: UITextView!
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var procrastinateDatePicker: UIDatePicker!
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if !(informationLink.text?.trimmingCharacters(in: .whitespaces).isEmpty)! {
            let s = SFSafariViewController(url: URL(string: (informationLink.text?.trimmingCharacters(in: .whitespaces))!)!)
            self.present(s, animated: true, completion: nil)
        }
        return true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = selected
        
        if UserDefaults.standard.bool(forKey: "\(listTitle!) \(selected!) isDone") == false {
            markAsDone.text = "Mark as done"
        } else {
            markAsDone.text = "It's not done!"
        }
        
        //MARK: - Set up
        if UserDefaults.standard.object(forKey: "\(listTitle!) \(selected!) procrastinate") != nil {
            procrastinateDatePicker.date = UserDefaults.standard.object(forKey: "\(listTitle!) \(selected!) procrastinate") as! Date
            remindMeOrNot.isOn = UserDefaults.standard.bool(forKey: "\(listTitle!) \(selected!) remindMeOrNot")
            excusesTextView.text = UserDefaults.standard.string(forKey: "\(listTitle!) \(selected!) excuses")
            urlTextField.text = UserDefaults.standard.string(forKey: "\(listTitle!) \(selected!) url")
            notesTextView.text = UserDefaults.standard.string(forKey: "\(listTitle!) \(selected!) notes")
        }
    }
    
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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        UserDefaults.standard.set(procrastinateDatePicker.date, forKey: "\(listTitle!) \(selected!) procrastinate")
        UserDefaults.standard.set(remindMeOrNot.isOn, forKey: "\(listTitle!) \(selected!) remindMeOrNot")
        UserDefaults.standard.set(excusesTextView.text, forKey: "\(listTitle!) \(selected!) excuses")
        UserDefaults.standard.set(urlTextField.text, forKey: "\(listTitle!) \(selected!) url")
        UserDefaults.standard.set(notesTextView.text, forKey: "\(listTitle!) \(selected!) notes")
    }
}
