//
//  CurrencyController.swift
//  ArmyOfOnes
//
//  Created by David Figueroa on 6/5/19.
//  Copyright © 2019 David Figueroa. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

struct CurrencyController {
    
    private static let queue = DispatchQueue(label: "com.hugeinc.armyofones.currencycontroller")
    
    static func getExchangeRate(completion: @escaping (Currency) -> ()) {
        let request = API.getExchangeRate(parameters:["base": "USD"])
        Alamofire.request(request).validate().responseJSON(queue: queue) { response in
            if response.error != nil {
                return
            }
            guard let value = response.result.value as? [String: Any],
                let currencies = Mapper<Currency>().map(JSON: value) else { return }
            completion(currencies)
        }
    }
}
