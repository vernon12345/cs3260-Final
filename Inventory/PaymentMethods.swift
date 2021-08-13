//
//  PaymentMethods.swift
//  Inventory
//
//  Created by user169317 on 8/10/21.
//

import Foundation

struct PaymentMethod: Hashable, Codable {
    var id: Int
    var title: String
    var type: String
}
