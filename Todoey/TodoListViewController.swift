//
//  ViewController.swift
//  Todoey
//
//  Created by Ron on 03/10/2018.
//  Copyright © 2018 Ron. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = ["Find Mike","Buy Eggos","Destory Demogorgon"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

        //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
       
        return cell
    }
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        //print (itemArray[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
        
         if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
    }
   
    // MARK - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default){ (action) in
        
            
            // What will happen once the user clicks the addItemButton on our UIAlert
            self.itemArray.append(textField.text!)
            self.tableView.reloadData()
             print ("succes")
        
        }
        
        
        alert.addTextField { (alertTexfield) in
            alertTexfield.placeholder = "Create New Item"
            textField = alertTexfield
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
}

