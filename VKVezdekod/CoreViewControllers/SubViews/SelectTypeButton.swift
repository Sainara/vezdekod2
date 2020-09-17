//
//  SelectTypeButton.swift
//  VKVezdekod
//
//  Created by Ян Мелоян on 11.09.2020.
//

import SnapKit
import UIKit

class SelectTypeButton: UIView {
    
    var action:(()->Void)?

    init(type:SelectType, action:@escaping ()->Void) {
        super.init(frame: .zero)
        
        backgroundColor = UIColor(hex: "#F5F5F5")
        clipsToBounds = true
        layer.cornerRadius = 10
        layer.borderWidth = 0.33
        layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.08).cgColor
        
        let typeImage = UIImageView()
        addSubview(typeImage)
        typeImage.snp.makeConstraints { (make) in
            make.width.equalTo(28)
            make.height.equalTo(28)
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(12).labeled("typeImage")
        }
        
        let textStackView = UIStackView()
        addSubview(textStackView)
        textStackView.snp.makeConstraints { (make) in
            make.leading.equalTo(typeImage.snp.trailing).offset(12).labeled("textStackView")
            make.top.equalTo(typeImage)
            make.bottom.equalToSuperview().offset(-12)
        }
        textStackView.axis = .vertical
        textStackView.spacing = 2
        textStackView.distribution = .fill
        textStackView.alignment = .top
        
        let titleText = UILabel(font: .systemFont(ofSize: 16, weight: .semibold), textColor: .black, textAlignment: .left, numberOfLines: 0)
        textStackView.addArrangedSubview(titleText)
        let descText = UILabel(font: .systemFont(ofSize: 13, weight: .regular), textColor: .primaryText, textAlignment: .left, numberOfLines: 0)
        textStackView.addArrangedSubview(descText)
        
        let chevronWrap = UIView()
        addSubview(chevronWrap)
        chevronWrap.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview().labeled("chevronWrap2")
            make.bottom.equalToSuperview()
            make.width.equalTo(48)
            make.leading.equalTo(textStackView.snp.trailing).offset(12).labeled("chevronWrap")
        }
        
        let chevron = UIImageView(image: UIImage(imageLiteralResourceName: "chevron_right_24"))
        chevronWrap.addSubview(chevron)
        chevron.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalTo(24)
            make.height.equalTo(24)
        }
        
        self.action = action
        
        let tap = UILongPressGestureRecognizer(target: self, action: #selector(onTap(_:)))
        tap.minimumPressDuration = 0
        addGestureRecognizer(tap)
        
        // Не знаю читаете ли вы, но напишу, вьюшка адаптивная, если текст будет много строчный ничего не сломается)
        switch type {
        case .celevoi:
            typeImage.image = UIImage(imageLiteralResourceName: "target_outline_28")
            titleText.text = "Целевой сбор"
            descText.text = "Когда есть определённая цель"
        case .regular:
            typeImage.image = UIImage(imageLiteralResourceName: "calendar_outline_28")
            titleText.text = "Регулярный сбор"
            descText.text = "Если помощь нужна ежемесячно"
        }
    }
    
    @objc private func onTap(_ tap:UILongPressGestureRecognizer) {
        if tap.state == .began {
            setOpacity(value: 0.7)
        }
        if tap.state == .ended {
            setOpacity(value: 1)
            action?()
        }
    }
    
    private func setOpacity(value:Float) {
        UIView.animate(withDuration: 0.2, animations:  {
            self.layer.opacity = value
        })
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

enum SelectType {
    case regular, celevoi // sorry ne pomnyu
}
