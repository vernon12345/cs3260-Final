//
//  ViewController.swift
//  Inventory
//
//  Created by user169317 on 6/28/21.
//

import UIKit
import SQLite3


struct Item {
    var sDescription: String = ""
    var lDescription: String = ""
    var pick:String = ""
}

var items: [Item] = []
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, Insert, Edit {
    var db: OpaquePointer?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.detailTextLabel?.text = items[indexPath.row].lDescription
        cell.textLabel?.text = items[indexPath.row].sDescription
        return cell
        
    }
    
        
    
    
    
    @IBOutlet weak var tableView: UITableView!
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          tableView.deselectRow(at: indexPath, animated: true)
      }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete"){ (action:UIContextualAction, sourceView: UIView, actionPerformed:(Bool) -> Void) in
            self.items.remove(at: indexPath.row)
            tableView.reloadData()
            actionPerformed(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    var items: [Item]! = []
    var iIndex: Int!
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "addSegue" {
            let view = segue.destination as! AddViewController
            view.delegate = self
        } else if segue.identifier == "editSegue" {
            let view = segue.destination as! EditViewController
            view.delegate = self
            iIndex = tableView.indexPathForSelectedRow?.row
            view.eShortDescription = items[iIndex].sDescription
            view.eLongDescription = items[iIndex].lDescription
            editRow(items[iIndex])
        }
        
    }
    func insertItem(_ item: Item){
        items.append(item)
        tableView.reloadData()
    }
    func editRow(_ item: Item){
        items[iIndex].sDescription = item.sDescription
        items[iIndex].lDescription = item.lDescription
        tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Sign Up"
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(saveToDatabase(_:)), name: UIApplication.willResignActiveNotification, object: nil)
        let fileUrl = try!
            FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("Inventory.sqlite")
        if sqlite3_open(fileUrl.path, &db) != SQLITE_OK{
            print("Error opening database")
            return
        }
        let createTable = "CREATE TABLE IF NOT EXISTS Items (id INTEGER PRIMARY KEY AUTOINCREMENT, shortDescription VARCHAR, longDescription VARCHAR, pick VARCHAR"
        
        if sqlite3_exec(db, createTable, nil, nil, nil) != SQLITE_OK{
            print("Error creating table")
            return
        }
        items.removeAll()
        let retrieveItem = "SELECT * FROM Items"
        var stmt:OpaquePointer?
        if sqlite3_prepare(db, retrieveItem, -1, &stmt, nil) != SQLITE_OK {
            print("Insert error")
        }
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let short = String(cString: sqlite3_column_text(stmt, 1))
            let long = String(cString: sqlite3_column_text(stmt, 2))
            let picker = String(cString: sqlite3_column_text(stmt, 3))
            items.append(Item.init(sDescription: short, lDescription: long, pick: picker))
        }
       
    }
    
    
    @objc func saveToDatabase(_ notification:Notification){

        let deleteStatementStirng = "DELETE * FROM Items;"
              
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {

            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted row.")
            } else {
                print("Could not delete row.")
            }
        } else {
            print("DELETE statement could not be prepared")
        }
            sqlite3_finalize(deleteStatement)

            print("delete")

        
        
        
        for item in items{
            let shortDescription = item.sDescription
            let longDescription = item.lDescription
            let picker = item.pick
            var stmt: OpaquePointer?
            let dbSave = "INSERT INTO Items (shortDescription, longDescription,picker) Values (?,?,?)"
            if sqlite3_prepare(db, dbSave, -1, &stmt, nil) != SQLITE_OK{
                print("binding error :dbSave")
            }
            if sqlite3_bind_text(stmt, 1, (shortDescription as NSString).utf8String, -1, nil) != SQLITE_OK {
                print("binding error :shortDescription")
            }
            if sqlite3_bind_text(stmt, 2, (longDescription as NSString).utf8String, -1, nil) != SQLITE_OK {
                           print("binding error :longDescription")
                       }
            if sqlite3_bind_text(stmt, 3, (picker as NSString).utf8String, -1, nil) != SQLITE_OK {
                           print("binding error :picker")
                       }
            sqlite3_step(stmt)
        }
            
        sqlite3_close(db)

    }


    
    
}

