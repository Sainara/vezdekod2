//
//  VKNavigationController.swift
//
//  Created by Ян Мелоян on 11.09.2020.
//  Copyright © 2020. All rights reserved.
//

import UIKit

class VKNavigationController: UINavigationController {

    let divider = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }
    
    init(rootViewController: UIViewController, isWithDivider:Bool = false) {
        super.init(rootViewController: rootViewController)
        if isWithDivider {
            addDivider()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    
    private func setup() {
        
        if #available(iOS 13.0, *) {
            // ios 13.0 and above
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.shadowColor = nil
            navBarAppearance.titleTextAttributes = [NSAttributedString.Key.font: FontProvider.standart.TTCommonDemiBold(ofSize: 21)]

            navBarAppearance.shadowImage = nil
            navBarAppearance.backgroundColor = .brandWhite
            navigationBar.standardAppearance = navBarAppearance
            navigationBar.scrollEdgeAppearance = navBarAppearance
        } else {
            // below ios 13.0
            navigationBar.shadowImage = UIImage()
            //navigationBar.backgroundImage = UIImage()
        }
        
        navigationBar.isTranslucent = false
        navigationBar.prefersLargeTitles = false
        navigationBar.tintColor = .brandBlack
        navigationBar.backgroundColor = .brandWhite
        
        navigationBar.titleTextAttributes = [NSAttributedString.Key.font: FontProvider.standart.TTCommonDemiBold(ofSize: 21)]
    }
    
    func addDivider() {
        navigationBar.addSubview(divider)
        divider.backgroundColor = .lightSeparator
        divider.snp.makeConstraints { (make) in
            make.height.equalTo(0.4)
            make.bottom.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-12)
            make.leading.equalToSuperview().offset(12)
        }
        
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        if ((viewController as? VKStackViewController) != nil) {
            divider.layer.opacity = 0
        } else {
            divider.layer.opacity = 1
        }
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        let result = super.popViewController(animated: animated)
        if ((topViewController as? VKStackViewController) != nil) {
            divider.layer.opacity = 0
        } else {
            divider.layer.opacity = 1
        }
        return result
    }
}
