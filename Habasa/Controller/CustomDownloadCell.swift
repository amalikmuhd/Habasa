//
//  CustomDownloadCell.swift
//  Habasa
//
//  Created by Mo Abdulmalik on 27/06/2019.
//  Copyright © 2019 Abdulmalik Muhammad. All rights reserved.
//

import UIKit

class CustomDownloadCell: UITableViewCell {

    
    
    @IBOutlet weak var filenameCell: UILabel!
    @IBOutlet weak var fileSizeCell: UILabel!
    @IBOutlet weak var downloadProgressCell: UIProgressView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
