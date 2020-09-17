//
//  InitViewController.swift
//  VKVezdekod
//
//  Created by Ян Мелоян on 11.09.2020.
//

import UIKit

class InitViewController: VKViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    init() {
        super.init(nibName: nil, bundle: nil)
        
        navigationItem.title = "Пожертвования"
        view.backgroundColor = .brandWhite
        
        setupView()
    }
    
    private func setupView() {
       
        let stackView = UIStackView()
        stackView.spacing = 0
        view.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        
        let text = VKLabel(text: "У Вас пока нет сборов.")
        text.textAlignment = .center
        stackView.addArrangedSubview(text)

        let text2 = VKLabel(text: "Начните доброе дело.")
        text2.textAlignment = .center
        stackView.addArrangedSubview(text2)
        //stackView.setCustomSpacing(24, after: text2)
        let padding = UILabel()
        stackView.addArrangedSubview(padding)
        padding.snp.makeConstraints { (make) in
            make.height.equalTo(24)
        }
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        
        let button = VKButton(text: "Создать сбор", fontSize: 15, height: 36, style: .small, action: toNextView)
        stackView.addArrangedSubview(button)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func toNextView() {
        let nextVC = SelectTypeViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
}

