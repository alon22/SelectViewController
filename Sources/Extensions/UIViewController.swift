//
//  UIViewController.swift
//  SelectViewController
//
//  Created by Rubén Alonso on 20/2/21.
//

import UIKit

extension UIViewController {
    var isModal: Bool {
        if presentingViewController != nil {
            return true
        }
        if navigationController?.presentingViewController?.presentedViewController == navigationController {
            return true
        }
        if tabBarController?.presentingViewController?.isKind(of: UITabBarController.self) ?? false {
            return true
        }
        return false
    }
}
