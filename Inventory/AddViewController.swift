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

class AddViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    let data = ["Add On:Enzyme Boost","Add On:Scent Booster","Add On:Sensative"]
    var pickerSelect:String = "Add On:Enzyme Boost"
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
  
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return data[row]
        }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
         pickerSelect = data[row]
    
    }
    
    
    
    func Display()-> Void{
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)-> String
        {
             pickerSelect = data[row]
            return pickerSelect
        }
        
        
        
        print("Place a string here, and a variable \(pickerSelect)")
        }
    
   
    
    
    
    
    var delegate: Insert!
    override func viewDidLoad() {
        super.viewDidLoad()
          picker.dataSource = self
          picker.delegate = self
        let save = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveItem))
        self.navigationItem.rightBarButtonItem = save
        self.navigationItem.title = "New Subscription"
    }

    
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var addShortDescription: UITextField!
    @IBOutlet weak var addLongDescription: UITextView!
    @objc func saveItem(){
        Display()
        delegate.insertItem(Item(sDescription: addShortDescription.text!, lDescription: addLongDescription.text!,pick:pickerSelect))
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnSave(_ sender: Any) {
        Display()
        delegate.insertItem(Item(sDescription: addShortDescription.text!, lDescription: addLongDescription.text!,pick:pickerSelect))
        self.navigationController?.popViewController(animated: true)
        
    }
}


    

