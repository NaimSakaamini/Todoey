//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Naim Sakaamini on 2019-05-17.
//  Copyright © 2019 Naim Sakaamini. All rights reserved.
//

import UIKit
import CoreData


class CategoryViewController: UITableViewController {

    var categoryArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategory()
    }

   
    
    //MARK: - TableView Datasource Methods
    
    //set the number of rows in a table
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    //create and set the value for each cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //create a reusable cell and add it to the table
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let category = categoryArray[indexPath.row]
        cell.textLabel?.text = category.name
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
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            self.categoryArray.append(newCategory)
            //save to database
            self.saveCategory()
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
    func saveCategory(){
        do{
            try context.save()
        } catch {
            print(error)
        }
        tableView.reloadData()
    }
    
    //load from database
    func loadCategory(){
        //fetch all data in the category entity
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        do{
            categoryArray = try context.fetch(request)
        } catch {
            print("error fetching")
        }
        tableView.reloadData()
    }
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
    }
}
