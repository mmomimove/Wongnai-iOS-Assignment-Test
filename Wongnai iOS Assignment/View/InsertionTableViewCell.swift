//
//  InsertionTableViewCell.swift
//  Wongnai iOS Assignment
//
//  Created by Suchaya K. on 14/1/2565 BE.
//

import UIKit

class InsertionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var insetionView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        insetionView.image = UIImage(named: "Image_insertion")
    }
    
}
