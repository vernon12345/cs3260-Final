//
//  test.swift
//  Inventory
//
//  Created by user169317 on 8/10/21.
//

import UIKit
import SwiftUI
import Stripe


class test: UIViewController {
    @IBOutlet weak var container:UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let childView = UIHostingController(rootView: Card())
        addChild(childView)
        childView.view.frame = container.bounds
        container.addSubview(childView.view)

       
}
}
