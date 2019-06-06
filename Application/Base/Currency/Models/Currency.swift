//
//  Currency.swift
//  ArmyOfOnes
//
//  Created by David Figueroa on 6/6/19.
//  Copyright © 2019 David Figueroa. All rights reserved.
//

import Foundation
import ObjectMapper

struct Currency {
    var base: String
    var rates: String


    //MARK: - Mappable
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        base <- map["value"]
        rates <- map["name"]
    }

    
}
