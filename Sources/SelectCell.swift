//
//  SelectCell.swift
//  SelectViewController
//
//  Created by Rubén Alonso on 7/2/21.
//

import UIKit

public class SelectCell: UITableViewCell {

    static var reuseID = "SelectCellID"

    public override func awakeFromNib() {
        super.awakeFromNib()
    }

    public override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .none
        accessoryType = isSelected ? .checkmark : .none
    }
}
