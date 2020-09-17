//
//  InputView.swift
//  VKVezdekod
//
//  Created by Ян Мелоян on 12.09.2020.
//

import UIKit

class InputView: UIView {
    
    var value:String?
    
    let textField = UITextField()
    let textView = UITextView()
    
    var placeholder:String

    init(title:String, placeholder:String, isMultiLine:Bool = false, isWithChevron:Bool = false) {
        self.placeholder = placeholder
        super.init(frame: .zero)
        let title = UILabel(text: title, font: .systemFont(ofSize: 14, weight: .regular), textColor: .primaryText, textAlignment: .left, numberOfLines: 0)
        addSubview(title)
        title.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.height.equalTo(18)
        }
        
        let textFieldWrap = UIView()
        addSubview(textFieldWrap)
        textFieldWrap.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-12)
            make.top.equalTo(title.snp.bottom).offset(12)
            make.trailing.equalTo(title)
            make.leading.equalTo(title)
            //make.height.equalTo(44)
        }
        textFieldWrap.clipsToBounds = true
        textFieldWrap.backgroundColor = .textFilldBackground
        textFieldWrap.layer.cornerRadius = 10
        textFieldWrap.layer.borderWidth = 0.5
        textFieldWrap.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.12).cgColor
        
        
        if isMultiLine {
            textFieldWrap.addSubview(textView)
            textView.textContainer.heightTracksTextView = true
            textView.isScrollEnabled = false
            textView.fillSuperview(padding: .init(top: 8, left: 12, bottom: 8, right: 12))
            textView.tintColor = .textFieldTintColor
            textView.textColor = .textFieldTintColor
            textView.font = .systemFont(ofSize: 16, weight: .regular)
            textView.backgroundColor = .clear
            textView.delegate = self
            textView.text = placeholder
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
        } else {
            textFieldWrap.addSubview(textField)
            textField.placeholder = placeholder
            textField.tintColor = .textFieldTintColor
            textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor : UIColor.textFieldTintColor])
            textField.font = .systemFont(ofSize: 16, weight: .regular)
            
            if isWithChevron {
                textField.isEnabled = false
                textField.snp.makeConstraints { (make) in
                    make.top.equalToSuperview().offset(12)
                    make.leading.equalToSuperview().offset(12)
                    make.bottom.equalToSuperview().offset(-12)
                }
                let chevronWrap = UIView()
                textFieldWrap.addSubview(chevronWrap)
                chevronWrap.snp.makeConstraints { (make) in
                    make.top.equalToSuperview()
                    make.trailing.equalToSuperview().labeled("chevronWrap2")
                    make.bottom.equalToSuperview()
                    make.width.equalTo(44)
                    make.leading.equalTo(textField.snp.trailing).offset(8).labeled("chevronWrap")
                }
                
                let chevron = UIImageView(image: UIImage(imageLiteralResourceName: "Dropdown Icon"))
                chevronWrap.addSubview(chevron)
                chevron.snp.makeConstraints { (make) in
                    make.center.equalToSuperview()
                    make.width.equalTo(24)
                    make.height.equalTo(24)
                }
            } else {
                textField.fillSuperview(padding: .allSides(12))
            }
            textField.addTarget(self, action: #selector(updateText(_:)), for: .allEvents)
        }
        
        
    }

    
    @objc private func updateText(_ textField:UITextField) {
        value = textField.text
    }
    
    func setValue(text:String) {
        textField.text = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension InputView: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let currentText: NSString = textView.text! as NSString
        let updatedText = currentText.replacingCharacters(in: range, with:text)
        
        if updatedText.isEmpty {
            textView.text = placeholder
            textView.textColor = UIColor.textFieldTintColor
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            return false
        }
        else if textView.textColor == UIColor.textFieldTintColor && !text.isEmpty {
            textView.text = nil
            textView.textColor = .black
        }
        
        return true
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        if window != nil {
            if textView.textColor == UIColor.textFieldTintColor {
                textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
            }
        }
    }
}
