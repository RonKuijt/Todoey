//
//  ViewController.swift
//  Todoey
//
//  Created by Ron on 03/10/2018.
//  Copyright © 2018 Ron. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController {

    var todoItems : Results<Item>?
    let realm = try! Realm()
    
    var selectedCategory: Category? {
        didSet {
            loadItems()
        }
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK - Tableview Datasource Methods
    
    // MARK: COUNT TABLEVIEW ROWS ITEMS
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    // MARK: FILL TABLEVIEW WITH ITEMS
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        //Korter maken van todoItems[indexPath.row].title
        if let item = todoItems?[indexPath.row] {
           cell.textLabel?.text = item.title
           cell.accessoryType = item.done ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No items added yet"
        }
        
        return cell
    }
    
    //MARK - TableView Delegate Methods
    
  
    //MARK: TABLEVIEW DIDSELECTROW
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    if let item = todoItems?[indexPath.row] {
        do {
            try realm.write {
                
                // realm.delete */ Delete selected row
                
                item.done = !item.done
            }
        } catch {
            print ("Error saving done status, \(error)")
        }
    }
    tableView.reloadData()
 }
    
    // MARK - ADD NEW ITEMS BUTTON PRESSED
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default){ (action) in
   
            if let currentCategory = self.selectedCategory {
                
                do {
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    }
                } catch {
                    print ("Error saving new items, \(error)")
                }
            }
            
        self.tableView.reloadData()
        
        }
            alert.addTextField { (alertTexfield) in
            alertTexfield.placeholder = "Create New Item"
            textField = alertTexfield
        }
        alert.addAction(action)
            
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: LOADITEMS
    func loadItems() {
        
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)

        tableView.reloadData()
    }
}

extension TodoListViewController: UISearchBarDelegate {

    // MARK: SEARCHBAR CLICKED FILTER
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

    todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
    tableView.reloadData()
    }

    // MARK: SEARCHBAR
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text?.count == 0 {
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}

