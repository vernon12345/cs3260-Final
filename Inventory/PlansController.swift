//
//  PlansController.swift
//  Inventory
//
//  Created by user169317 on 7/17/21.
//

import UIKit

class PlansController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.title = "Subscribers"
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(editTapped(_:)), name: UIApplication.willResignActiveNotification, object: nil)
    }
    
    @objc func editTapped(_ notification:Notification){
       print ("edit")
    }
    

}
