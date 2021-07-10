//
//  viewCartTableViewCell.swift
//  hackintoshios
//
//  Created by Venkat on 10/07/21.
//

import UIKit

class viewCartTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productSKU: UILabel!
    @IBOutlet weak var productTotalAmount: UILabel!
    @IBOutlet weak var lessBtn: UIButton!
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var quantityBtn: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        stackView.layer.cornerRadius = 5
        stackView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
