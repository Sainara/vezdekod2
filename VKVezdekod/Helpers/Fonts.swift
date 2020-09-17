//
//  FontProvider.swift
//
//  Created by Ян Мелоян on 11.09.2020.
//  Copyright © 2020. All rights reserved.
//

import UIKit

class FontProvider {
    private let ttComomons = "TTCommons-DemiBold"
    
    func TTCommonDemiBold(ofSize: CGFloat) -> UIFont {
        guard let customFont = UIFont(name: ttComomons, size: ofSize) else {
            return .systemFont(ofSize: ofSize)
        }
        return customFont
    }
    
    private init() {}
    
    static let standart = FontProvider()
}
