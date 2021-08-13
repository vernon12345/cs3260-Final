//
//  EditViewController.swift
//  Inventory
//
//  Created by user169317 on 7/1/21.
//

import UIKit

protocol Edit{
    func editRow(_ item: Item)
}


class EditViewController: UIViewController {
    var eShortDescription: String = ""
    var eLongDescription: String = ""
    var delegate: Edit!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let save = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveItem))
        self.navigationItem.rightBarButtonItem = save
        self.navigationItem.title = "Edit Subscription"
        editShortDescription.text = eShortDescription
        editLongDescription.text = eLongDescription
    }
    
    
    @IBOutlet weak var editShortDescription: UITextField!
    @IBOutlet weak var editLongDescription: UITextView!
    @objc func saveItem(){
        delegate.editRow(Item(sDescription: editShortDescription.text!, lDescription: editLongDescription.text!))
        self.navigationController?.popViewController(animated: true)
       }

    

}
