//
//  CustomCell.swift
//  SelectViewController Example
//
//  Created by Rubén Alonso on 28/2/21.
//

import UIKit
import SelectViewController

class CustomCell: UITableViewCell, SelectCell {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelNote: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
