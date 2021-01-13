//
//  FilterOptionTableViewCell.swift
//  ZalandoAPPDemo
//
//  Created by Umut SERIFLER on 13/01/2021.
//

import UIKit

class FilterOptionTableViewCell: UITableViewCell {

    @IBOutlet var dotView: UIView!
    @IBOutlet var filterName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override var isSelected: Bool{
        didSet{
            self.dotView.isHidden = !isSelected
        }
    }
    
}
