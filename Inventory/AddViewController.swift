//
//  AddViewController.swift
//  Inventory
//
//  Created by user169317 on 7/1/21.
//

import UIKit

protocol Insert{
    func insertItem(_ item: Item)
}

class AddViewController: UIViewController {
    var delegate: Insert!
    override func viewDidLoad() {
        super.viewDidLoad()
        let save = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveItem))
        self.navigationItem.rightBarButtonItem = save
        self.navigationItem.title = "Add New Item"
    }
    
    @IBOutlet weak var addShortDescription: UITextField!
    @IBOutlet weak var addLongDescription: UITextView!
    @objc func saveItem(){
        delegate.insertItem(Item(sDescription: addShortDescription.text!, lDescription: addLongDescription.text!))
        self.navigationController?.popViewController(animated: true)
    }

}
