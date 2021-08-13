//
//  BackendModel.swift
//  Inventory
//
//  Created by user169317 on 8/10/21.
//

import Foundation
import Stripe
import SwiftUI

class BackendModel : ObservableObject {
    @Published var paymentStatus: STPPaymentHandlerActionStatus?
    @Published var paymentIntentParams: STPPaymentIntentParams?
    @Published var lastPaymentError: NSError?
    var paymentMethodType: String?
    var currency: String?
    var amount: String?
    let publishableKey = "pk_test_51H2Ih0AZPCfMwwetZ3VMU1grRlkNbezzCI1puNK6JNWBTSTbgpeXltvqW6OiksLtP6piuDJB3p1wEUTbndbok2Tp00aXEqKdJF"
    init(){
    StripeAPI.defaultPublishableKey = publishableKey
        
    }
    
    
    



    
    

    func preparePaymentIntent(paymentMethodType: String, currency: String ,amount:String) {
        let doller = "200"
        self.paymentMethodType = paymentMethodType
        self.currency = currency
        self.amount = doller        // MARK: Fetch the PaymentIntent from the backend
        // Create a PaymentIntent by calling the sample server's /create-payment-intent endpoint.
        let url = URL(string: BackendUrl + "create-payment-intent")!
        let json: [String: Any] = [
                "currency": currency,
                "paymentMethodType": paymentMethodType,
                "amount":doller
        ]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: json)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { [weak self] (data, response, error) in
                guard let response = response as? HTTPURLResponse,
                        response.statusCode == 200,
                        let data = data,
                        let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any],
                        let clientSecret = json["clientSecret"] as? String else {
                                let message = error?.localizedDescription ?? "Failed to decode response from server."
                                print(message)
                                return
                }
                print("Created PaymentIntent")
                // MARK: Create the PaymentIntent
                DispatchQueue.main.async {
                    self?.paymentIntentParams = STPPaymentIntentParams(clientSecret: clientSecret)
                }
        })
        task.resume()
    }
    
    func onCompletion(status: STPPaymentHandlerActionStatus, pi: STPPaymentIntent?, error: NSError?) {
        self.paymentStatus = status
        self.lastPaymentError = error

        // MARK: Demo cleanup
        if status == .succeeded {
            // A PaymentIntent can't be reused after a successful payment. Prepare a new one for the demo.
            self.paymentIntentParams = nil
            preparePaymentIntent(paymentMethodType: self.paymentMethodType!, currency: self.currency!, amount: self.amount!)
        }
    }
    
    
}






