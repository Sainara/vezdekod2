//
//  RouteProvider.swift
//
//  Created by Ян Мелоян on 11.09.2020.
//  Copyright © 2020. All rights reserved.
//

import Foundation
import UIKit

class RouteProvider {
    private init() {}
    
    static let shared = RouteProvider()
    
    func initViewController() -> UIViewController {
//        guard SaveRestoreProvider.shared.restoreToken() != nil else {
//            return EnterPhoneViewController()
//        }
//        if CodeEntity.shared.code == nil {
//            return EnterCodeOrFaceID(target: .createCode)
//        }
        return VKNavigationController(rootViewController: InitViewController(), isWithDivider: true)
    }
//
//    func enteredCode(isValidOrOnIt:Bool) -> UIViewController {
//        if isValidOrOnIt {
//            return MainTabBarViewController()
//        }
//        return SelectOrgTypeViewController() // EnterVal...
//    }
//
//    func firstEnterView() -> UIViewController {
//        let vc = EnterPhoneViewController()
//        vc.modalPresentationStyle = .fullScreen
//
//        return vc
//    }
    
    static func switchRootViewController(rootViewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        guard let window = UIApplication.shared.keyWindow else { return }
        if animated {
            UIView.transition(with: window, duration: 0.3, options: .curveEaseIn, animations: {
                let oldState: Bool = UIView.areAnimationsEnabled
                UIView.setAnimationsEnabled(false)
                window.rootViewController = rootViewController
                UIView.setAnimationsEnabled(oldState)
            }, completion: { (finished: Bool) -> () in
                if (completion != nil) {
                    completion!()
                }
            })
        } else {
            window.rootViewController = rootViewController
        }
    }
}

