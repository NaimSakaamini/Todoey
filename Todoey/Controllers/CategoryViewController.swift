//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Naim Sakaamini on 2019-05-17.
//  Copyright © 2019 Naim Sakaamini. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController {

    let realm = try! Realm()
    
    //create a category array of type results that contain Category objects
    var categoryArray : Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategory()
        
        tableView.separatorStyle = .none
    }

   
    
    //MARK: - TableView Datasource Methods
    
    //set the number of rows in a table
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //nil coalescing operator.. this will get the count of the array if it isnt nil but if it is it will return 1
        return categoryArray?.count ?? 1
    }
    
    
    //overrides the super function
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //access the cell that is created in the super class
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        if let category = categoryArray?[indexPath.row] {
            cell.textLabel?.text = category.name
            
            guard let categoryColor = UIColor(hexString: category.bgColor) else {fatalError()}
            
            cell.backgroundColor = categoryColor
            cell.textLabel?.textColor = ContrastColorOf(categoryColor, returnFlat: true)
        }
        
        return cell
    }
    
    
    //MARK: - Add New Category
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        //create an alert when button pressed
        let alert = UIAlertController(title: "add new category", message: "", preferredStyle: .alert)
        
        //alerts action
        let action = UIAlertAction(title: "add category", style: .default) { (action) in
            //add new categry to the context
            let newCategory = Category()
            newCategory.name = textField.text!
            newCategory.bgColor = UIColor.randomFlat.hexValue()
            
            //save to database
            self.save(category: newCategory)
        }
        
        alert.addAction(action)

        //alerts textfield
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add new category"
            textField = alertTextField
        }
        

        //present the alert
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Data Manupulation Methods
    //save data to the database
    func save(category: Category){
        do{
            try realm.write {
                realm.add(category)
            }
        } catch {
            print(error)
        }
        tableView.reloadData()
    }
    
    //load from database
    func loadCategory(){
        //fetch all data in the category entity
       categoryArray = realm.objects(Category.self)
        tableView.reloadData()
    }
    
    //delete method
    override func updateModel(at indexPath: IndexPath) {
        if let categoryToDelete = self.categoryArray?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(categoryToDelete.items)
                    self.realm.delete(categoryToDelete)

                }
            } catch {
                print(error)
            }
        }
    }
    
    
    
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categoryArray?[indexPath.row]
        }
    }
}
    

