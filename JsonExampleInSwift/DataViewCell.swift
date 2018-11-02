//
//  DataViewCell.swift
//  JsonExampleInSwift
//
//  Created by PASHA on 01/11/18.
//  Copyright © 2018 Pasha. All rights reserved.
//

import UIKit

class DataViewCell: UITableViewCell {

  @IBOutlet weak var imageV: UIImageView!
  @IBOutlet weak var nameLbl: UILabel!
  @IBOutlet weak var discriptionLbl: UILabel!
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
