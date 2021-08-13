//
//  PaymentMethodRow.swift
//  Inventory
//
//  Created by user169317 on 8/10/21.
//

import SwiftUI

struct PaymentMethodRow: View {
    var paymentMethod: PaymentMethod
    
    var body: some View {
        HStack {
            Text(paymentMethod.title)
        }
    }
}

struct PaymentMethodRow_Previews: PreviewProvider {
    static var previews: some View {
        PaymentMethodRow(paymentMethod: paymentMethods[0])
    }
}
