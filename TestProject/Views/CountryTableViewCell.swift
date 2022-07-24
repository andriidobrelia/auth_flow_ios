//
//  CountryTableViewCell.swift
//  TestProject
//
//  Created by Andrew Dobrelya on 03.07.2022.
//

import UIKit

class CountryTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        selectionStyle = .none
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet var capitalLabel: UILabel!
    @IBOutlet var countryImg: UIImageView!
    @IBOutlet var countryView: UIView!
    @IBOutlet var countryLabel: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
