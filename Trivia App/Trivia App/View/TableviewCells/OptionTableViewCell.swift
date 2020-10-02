//
//  OptionTableViewCell.swift
//  Trivia App
//
//  Created by Shaktiprasad Mohanty on 02/10/20.
//

import UIKit

class OptionTableViewCell: UITableViewCell {
    @IBOutlet weak var lblOption: UILabel!
    @IBOutlet weak var btnOption: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
