//
//  CurrencyController.swift
//  ArmyOfOnes
//
//  Created by David Figueroa on 6/5/19.
//  Copyright © 2019 David Figueroa. All rights reserved.
//

import Foundation
import Alamofire

struct CurrencyController {
    
    private static let queue = DispatchQueue(label: "com.hugeinc.armyofones.currencycontroller")
    
    static func getExchangeRate(amount: Float) -> [Currency] {
        let request = API.getExchangeRate(parameters:["base": "USD"])
        Alamofire.request(request).validate().responseJSON(queue: queue) { response in
            if response.error != nil {
                return
            }
            if let value = response.result.value as? [String: Any] {
                //                trips = Mapper<Trip>().mapArray(JSONObject: value["data"])?.sorted { ($0.id ?? 0) >= ($1.id ?? 0) }
                print(value)
                //            }
                //            if trips != nil {
                //                storedTrips.forEach { storedTrip in
                //                    if !(trips!.contains { $0.id == storedTrip.id } ) { TripStore.delete(storedTrip) }
                //                }
                //                TripStore.save(trips)
                //            }
                //            DispatchQueue.main.async {
                //                completion(trips, response.error)
                //            }
            }
        }
        
        var currencyArray = [Currency]()
        currencyArray.append(Currency(name: "EUR", value: 12.1))
        currencyArray.append(Currency(name: "SA", value: 4.1))
        currencyArray.append(Currency(name: "ASD", value: 2.1))
        currencyArray.append(Currency(name: "asdas", value: 10.1))
        return currencyArray
    }
}
