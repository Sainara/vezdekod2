//
//  VKButton.swift
//
//  Created by Ян Мелоян on 11.09.2020.
//  Copyright © 2020. All rights reserved.
//

import UIKit
import SnapKit

class VKButton: UIButton {
    
    var action:(()->Void)?

    init() {
        super.init(frame: .zero)
    }
    
    convenience init(text:String, fontSize: CGFloat = 17, height:CGFloat = 44, width:CGFloat? = nil, style:YoustersButtonStyle = .basic, action:@escaping ()->Void) {
        self.init()
        setTitle(text, for: .normal)
        titleLabel?.font = .systemFont(ofSize: fontSize, weight: .medium)
        
        setBackgroundColor(color: .primaryButtonColor, forState: .normal)
        setBackgroundColor(color: .primaryButtonDisabled, forState: .disabled)
        setBackgroundColor(color: .primaryButtonHighlited, forState: .highlighted)
        titleLabel?.textColor = .white
        
        switch style {
        case .basic:
            break
        case .small:
            snp.makeConstraints { (make) in
                make.width.equalTo(text.widthOfString(usingFont: .systemFont(ofSize: fontSize, weight: .medium)) + 32)
            }
            titleEdgeInsets = .init(top: 7.5, left: 16, bottom: 8.5, right: 16)
        }
        
        snp.makeConstraints { (make) in
            make.height.equalTo(height)
        }
        
        layer.cornerRadius = 10
        clipsToBounds = true
        
        addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        self.action = action
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonAction() {
        action?()
    }

    enum YoustersButtonStyle {
        case basic, small
    }

}

extension UIButton {
    func setBackgroundColor(color: UIColor, forState: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
            let colorImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.setBackgroundImage(colorImage, for: forState)
        }
    }
}
