//
//  ViewController.swift
//  Inventory
//
//  Created by user169317 on 6/28/21.
//

import UIKit


struct Item {
    var sDescription: String = ""
    var lDescription: String = ""
}

var items: [Item] = []
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, Insert, Edit {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].sDescription
        cell.detailTextLabel?.text = items[indexPath.row].lDescription
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
        self.navigationItem.title = "Inventory"
    }
}

