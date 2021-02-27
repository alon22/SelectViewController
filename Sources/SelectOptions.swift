//
//  SelectOptions.swift
//  SelectViewController
//
//  Created by Rubén Alonso on 7/2/21.
//

import UIKit

public struct SelectOptions {
    public var multipleSelection = false
    public var dismissAtSelection = true
    public var closeImage: UIImage?
    public var title: String?
}

public enum SelectType {
    case `default`
    case custom(Int)
}
