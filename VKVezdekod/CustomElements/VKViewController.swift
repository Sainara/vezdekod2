//
//  YoustersViewController.swift
//
//  Created by Ян Мелоян on 11.09.2020.
//  Copyright © 2020. All rights reserved.
//

import LBTATools
import UIKit
import SnapKit

class VKViewController: UIViewController {
    
    var bottomConstraint: Constraint? = nil
    var bottomOffset: CGFloat = 0.0
    var bottomPaddinng: CGFloat = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: title ?? "", style: .plain, target: nil, action: nil)
        
        navigationItem.backBarButtonItem?.tintColor = .lightHeaderTint
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func addDivider() {
        let divider = UILabel()
        view.addSubview(divider)
        divider.backgroundColor = .lightSeparator
        divider.snp.makeConstraints { (make) in
            make.height.equalTo(0.4)
            make.top.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-12)
            make.leading.equalToSuperview().offset(12)
        }
    }
    
    @objc func keyBoardWillShow(notification: NSNotification) {
        
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            bottomConstraint?.update(offset: -keyboardHeight + view.safeAreaInsets.bottom - bottomPaddinng)
            UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }) { (completed) in
            }
        }
    }
    
    @objc func keyBoardWillHide(notification: NSNotification) {
        
        bottomConstraint?.update(offset: bottomOffset)
        UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }) { (completed) in
            
        }
    }
    
    func addCloseItem(addFromSuper:Bool = false, color:UIColor = .bgColor) {
        let close = UIButton(title: "Закрыть", titleColor: color)
        //close.titleLabel?.font = Fonts.standart.gilroyMedium(ofSize: 15)
        close.contentHorizontalAlignment = .trailing
        close.addTarget(self, action: #selector(closeMe), for: .touchUpInside)
        view.addSubview(close)
        close.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
    }
    
    func addCloseItem(addFromSuper: Bool) {
        let close = UIButton(title: "Закрыть", titleColor: .bgColor)
        //close.titleLabel?.font = Fonts.standart.gilroyMedium(ofSize: 15)
        close.contentHorizontalAlignment = .trailing
        close.addTarget(self, action: #selector(closeMe), for: .touchUpInside)
        view.addSubview(close)
        close.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
    }
    
    @objc internal func closeMe() {
//        self.dismiss(animated: true, completion: nil)
//        let mainViewController = self.presentingViewController as? MainDocsViewController
//        mainViewController?.getData()
    }
}
