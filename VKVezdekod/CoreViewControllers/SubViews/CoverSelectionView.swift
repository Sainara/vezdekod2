//
//  CoverSelectionView.swift
//  VKVezdekod
//
//  Created by Ян Мелоян on 12.09.2020.
//

import UIKit

class CoverSelectionView: UIView {

    let picker = UIImagePickerController()
    
    var delegate:CoverDelegate?
    
    init() {
        super.init(frame: .zero)
        buildUnselectedView()
    }
    
    private func buildUnselectedView() {
        let imagePlaceHolderView = UIView()
        addSubview(imagePlaceHolderView)
        imagePlaceHolderView.fillSuperview(padding: .init(top: 0, left: 12, bottom: 12, right: 12))
        imagePlaceHolderView.clipsToBounds = true
        imagePlaceHolderView.layer.cornerRadius = 10
        
        imagePlaceHolderView.snp.makeConstraints { (make) in
            make.height.equalTo(140)
        }
            
        let yourViewBorder = CAShapeLayer()
        yourViewBorder.strokeColor = UIColor.lightHeaderTint.cgColor
        yourViewBorder.lineDashPattern = [4, 4]
        yourViewBorder.lineWidth = 1
        yourViewBorder.frame = .init(x: 0, y: 0, width: UIScreen.main.bounds.width - 24, height: 140)
        
        yourViewBorder.fillColor = nil
        yourViewBorder.path = UIBezierPath(roundedRect: .init(x: 0, y: 0, width: UIScreen.main.bounds.width - 24, height: 140), cornerRadius: 10).cgPath
        imagePlaceHolderView.layer.addSublayer(yourViewBorder)
        
        let hStack = UIStackView()
        hStack.distribution = .fill
        hStack.spacing = 8
        imagePlaceHolderView.addSubview(hStack)
        hStack.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        hStack.axis = .horizontal
        
        let imageView = UIImageView(image: UIImage(imageLiteralResourceName: "picture_outline_28"))
        imageView.snp.makeConstraints { (make) in
            make.width.equalTo(28)
            make.height.equalTo(28)
        }
        hStack.addArrangedSubview(imageView)
        
        let title = UILabel(text: "Загрузить обложку", font: .systemFont(ofSize: 16, weight: .medium), textColor: .lightHeaderTint, textAlignment: .left, numberOfLines: 0)
        title.snp.makeConstraints { (make) in
            make.width.equalTo("Загрузить обложку".widthOfString(usingFont: .systemFont(ofSize: 16, weight: .medium)))
        }
        hStack.addArrangedSubview(title)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectTap))
        imagePlaceHolderView.addGestureRecognizer(tapGesture)
    }
    
    private func buildWithImage(image:UIImage?) {
        let imageView = UIImageView()
        addSubview(imageView)
        imageView.fillSuperview(padding: .init(top: 0, left: 12, bottom: 12, right: 12))
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
        
        imageView.snp.makeConstraints { (make) in
            make.height.equalTo(140)
        }
        
        imageView.image = image
        
        let button = UIButton()
        button.setImage(UIImage(imageLiteralResourceName: "dismiss_overlay_24"), for: .normal)
        addSubview(button)
        button.snp.makeConstraints { (make) in
            make.width.equalTo(24)
            make.height.equalTo(24)
            make.top.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        button.addTarget(self, action: #selector(resettImage), for: .touchUpInside)

    }
    
    func buildView(state:State) {
        subviews.forEach {$0.removeFromSuperview()}
        print("func buildView(state:State) {")
        switch state {
        case .noSelected:
            buildUnselectedView()
        case .selected(let image):
            
            buildWithImage(image: image)
        }
    }
    
    @objc func selectTap() {
        delegate?.onTap()
    }
    
    @objc func resettImage() {
        print("@objc func resetImage() {")
        buildView(state: .noSelected)
    }
    
    enum State {
        case noSelected, selected(image:UIImage?)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
