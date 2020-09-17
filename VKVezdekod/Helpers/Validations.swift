//
//  Validations.swift
//
//  Created by Ян Мелоян on 11.09.2020.
//  Copyright © 2020. All rights reserved.
//

import Foundation

class Validations {
    static func checkName(name:String, withCount:Int = 60) -> Bool {
        if name.isEmpty || name.count > withCount {
            return false
        }
        return true
    }
    
    static func checkPrice(digits:String) -> Bool {
        return Int(digits) != nil
    }
}
