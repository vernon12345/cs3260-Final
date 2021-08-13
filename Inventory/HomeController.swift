//
//  HomeController.swift
//  Inventory
//
//  Created by user169317 on 7/17/21.
//

import UIKit
import SwiftUI

class HomeController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "Something Else", style: .plain, target: nil, action: nil)
        // Do any additional setup after loading the view.
    }
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            
        }
    
        
        
        
        
        
    }

}
