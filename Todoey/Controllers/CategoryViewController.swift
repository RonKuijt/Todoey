//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Ron on 11/10/2018.
//  Copyright © 2018 Ron. All rights reserved.
//


import UIKit
import RealmSwift
import ChameleonFramework


class CategoryViewController: SwipeTableViewController {

    let realm = try! Realm()
    var categories: Results<Category>?
 
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        loadCategories()
    }

    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name ?? "Nog geen catergorieen ingevoerd."
        cell.backgroundColor = UIColor(hexString: categories?[indexPath.row].color ?? "1D9BF6")
        cell.textLabel?.textColor = ContrastColorOf(cell.backgroundColor!, returnFlat: true)
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GoToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
    //MARK: - Data Manipulation Methods

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    
        var textField = UITextField()
    
        let alert = UIAlertController(title: "Nieuwe catergorie", message: "", preferredStyle: .alert)
    
        let action = UIAlertAction(title: "Toevoegen", style: .default){ (action) in
        
        let newCategory = Category()
        
        newCategory.name = textField.text!
        newCategory.color = UIColor.randomFlat.hexValue()
        self.save(category: newCategory)
            
    }
    
    alert.addTextField { (alertTexfield) in
        alertTexfield.placeholder = "Nieuwe catergorie"
        textField = alertTexfield
    }
    
    alert.addAction(action)
    
    present(alert, animated: true, completion: nil)
    
}
    
// MARK: Save Categories
    func save(category: Category) {
    
        do {
            try realm.write {
                realm.add(category)
           }
        } catch {
            print ("Error save context, \(error)")
        }
    
    tableView.reloadData()
}

//MARK: Load Categories
    func loadCategories() {
    
        categories = realm.objects(Category.self)
        tableView.reloadData()
    }
    
    
    override func updateModel(at indexPath: IndexPath) {
        if let catergoryForDeletion = self.categories?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(catergoryForDeletion)
                }
            } catch {
                print ("Error deleting category, \(error)")
            }
        }
    }
}


