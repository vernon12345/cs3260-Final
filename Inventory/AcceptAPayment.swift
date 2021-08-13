//
//  AcceptAPayment.swift
//  Inventory
//
//  Created by user169317 on 8/10/21.
//

import SwiftUI
import Stripe


let BackendUrl = "http://127.0.0.1:4242/"

let publishableKey="pk_test_51H2Ih0AZPCfMwwetZ3VMU1grRlkNbezzCI1puNK6JNWBTSTbgpeXltvqW6OiksLtP6piuDJB3p1wEUTbndbok2Tp00aXEqKdJF"
struct AcceptAPaymentApp: App {
    
    init() {
        let url = URL(string: BackendUrl + "config")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            guard let response = response as? HTTPURLResponse,
                response.statusCode == 200,
                let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any],
                let publishableKey = json["publishableKey"] as? String else {
                print("Failed to retrieve publishableKey from /config")
                return
            }
            print("Fetched publishable key \(publishableKey)")
            StripeAPI.defaultPublishableKey = publishableKey
        })
        task.resume()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL { url in
                    // This method handles opening custom URL schemes (e.g., "your-app://")
                    print(url)
                    let stripeHandled = StripeAPI.handleURLCallback(with: url)
                    if (!stripeHandled) {
                        // This was not a Stripe url – handle the URL normally as you would
                    }
                }
        }
    }
}



