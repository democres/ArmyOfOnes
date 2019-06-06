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
    static func getExchangeRate(amount: Float) -> [Currency] {
        var currencyArray = [Currency]()
        currencyArray.append(Currency(name: "EUR", value: 12.1))
        currencyArray.append(Currency(name: "SA", value: 4.1))
        currencyArray.append(Currency(name: "ASD", value: 2.1))
        currencyArray.append(Currency(name: "asdas", value: 10.1))
        return currencyArray
    }
}
