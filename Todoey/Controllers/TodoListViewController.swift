//
//  ViewController.swift
//  Todoey
//
//  Created by Ron on 03/10/2018.
//  Copyright © 2018 Ron. All rights reserved.
//

import UIKit


class TodoListViewController: UITableViewController {

    var itemArray = [Item]()

    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Buy Eggos"
        itemArray.append(newItem2)

        let newItem3 = Item()
        newItem3.title = "Kiss Ron"
        itemArray.append(newItem3)

        let newItem4 = Item()
        newItem4.title = "Do important things"
        itemArray.append(newItem4)

//        if let items = defaults.array (forKey: "TodoListArray") as? [Item] {
//
//        itemArray = items
//
//    }
        
        
    }
        //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        //Korter maken van itemArray[indexPath.row].title
        let item = itemArray[indexPath.row]
        
        //i.p.v. cell.textLabel?.text = itemArray[indexPath.row].title
        cell.textLabel?.text = item.title
        
        
        //Ternary operator =>
        // value = condition ? valueIfTrue : valueIfFalse
        
        cell.accessoryType = item.done ? .checkmark : .none
        
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
        
        return cell
    }
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    // Als .done = waar zet deze op onwaar en andersom
    itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
    saveItems()
    
    tableView.deselectRow(at: indexPath, animated: true)
        
    }
   
    // MARK - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default){ (action) in
        
        // What will happen once the user clicks the addItemButton on our UIAlert
            let newItem = Item()
            
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
        
            self.saveItems()
        }
            
        alert.addTextField { (alertTexfield) in
            alertTexfield.placeholder = "Create New Item"
            textField = alertTexfield
        }
            
        alert.addAction(action)
            
        present(alert, animated: true, completion: nil)
        
    }
        
    
    func saveItems() {
        
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print ("Error encoding item array, \(error)")
          }
        
        tableView.reloadData()
        
        }
    
}

