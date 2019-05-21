//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Naim Sakaamini on 2019-05-17.
//  Copyright © 2019 Naim Sakaamini. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {

    let realm = try! Realm()
    
    //create a category array of type results that contain Category objects
    var categoryArray : Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategory()
    }

   
    
    //MARK: - TableView Datasource Methods
    
    //set the number of rows in a table
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //nil coalescing operator.. this will get the count of the array if it isnt nil but if it is it will return 1
        return categoryArray?.count ?? 1
    }
    
    //create and set the value for each cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //create a reusable cell and add it to the table
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
       
        cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "No categories added"
        
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
