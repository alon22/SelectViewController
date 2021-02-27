//
//  SelectViewControllerDelegate.swift
//  SelectViewController
//
//  Created by Rubén Alonso on 13/2/21.
//

import Foundation

public protocol SelectViewControllerDelegate {
    func selectViewController(didSelect items: [Any], inType: SelectType)
    func selectViewControllerWillDismiss(for type: SelectType)
    func selectViewControllerDidDismiss(for type: SelectType)
}

public extension SelectViewControllerDelegate {
    func selectViewControllerWillDismiss(for type: SelectType) {
        print("selectViewControllerWillDismiss: for \(String(describing: type))")
    }
    func selectViewControllerDidDismiss(for type: SelectType) {
        print("selectViewControllerDidDismiss: for \(String(describing: type))")
    }
}
