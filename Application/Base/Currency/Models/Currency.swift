//
//  Currency.swift
//  ArmyOfOnes
//
//  Created by David Figueroa on 6/6/19.
//  Copyright © 2019 David Figueroa. All rights reserved.
//

import Foundation
import ObjectMapper

struct Currency: Mappable {
    var base: String?
    var rates: [String:Any]?


    //MARK: - Mappable
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        base <- map["base"]
        rates <- map["rates"]
    }
    
}
