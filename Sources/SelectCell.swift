//
//  SelectCell.swift
//  SelectViewController
//
//  Created by Rubén Alonso on 7/2/21.
//

import UIKit

public protocol SelectCell {
    static func reuseId() -> String
    static func nib() -> UINib
}

extension SelectCell {
    public static func reuseId() -> String {
        return String(describing: "\(Self.self)Id")
    }

    public static func nib() -> UINib {
        return UINib(nibName: String(describing: "\(Self.self)"), bundle: nil)
    }
}

open class SelectViewCell: UITableViewCell, SelectCell {

    open override func awakeFromNib() {
        super.awakeFromNib()
    }

    open override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .none
        accessoryType = isSelected ? .checkmark : .none
    }
}
