//
//  SelectTypeViewController.swift
//  VKVezdekod
//
//  Created by Ян Мелоян on 11.09.2020.
//

import UIKit

class SelectTypeViewController: VKViewController {

    init() {
        super.init(nibName: nil, bundle: nil)
        
        navigationItem.title = "Тип сбора"
        view.backgroundColor = .brandWhite
        
        setupView()
    }
    
    private func setupView() {
       
        let stackView = UIStackView()
        stackView.spacing = 16
        view.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 8, left: 12, bottom: 8, right: 12)
        //stackView.alignment = .center
        
        stackView.addArrangedSubview(SelectTypeButton(type: .celevoi, action: {
            self.pushCreate(type: .celevoi)
        }))
        stackView.addArrangedSubview(SelectTypeButton(type: .regular, action: {
            self.pushCreate(type: .regular)
        }))
    }
    
    private func pushCreate(type:SelectType) {
        navigationController?.pushViewController(CreateFirstStepViewController(type: type), animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func toNextView() {
        
    }
    
}
