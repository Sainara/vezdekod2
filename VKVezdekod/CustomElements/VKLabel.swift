//
//  VKLabel.swift
//  VKVezdekod
//
//  Created by Ян Мелоян on 11.09.2020.
//

import UIKit

class VKLabel: UILabel {
    
    init(text:String) {
        super.init(frame: .zero)
        self.text = text
        self.font = .systemFont(ofSize: 16)
        self.textColor = UIColor(hex: "#818C99")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
