//
//  ExtraStepViewController.swift
//  VKVezdekod
//
//  Created by Ян Мелоян on 12.09.2020.
//

import UIKit

class ExtraStepViewController: VKStackViewController {

    init() {
        super.init(nibName: nil, bundle: nil)
        
        navigationItem.title = " Дополнительно"
        view.backgroundColor = .brandWhite
        
        let authorField = InputView(title: "Автор", placeholder: "Матвей Правосудов", isWithChevron: true)
        authorField.setValue(text: "Матвей Правосудов")
        stackView.addArrangedSubview(authorField)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
}
}
