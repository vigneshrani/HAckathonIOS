//
//  TimeDeliverTableViewCell.swift
//  hackintoshios
//
//  Created by Venkat on 10/07/21.
//

import UIKit

class TimeDeliverTableViewCell: UITableViewCell {

    @IBOutlet weak var radioBtn: UIButton!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
