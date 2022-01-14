//
//  ListTableViewCell.swift
//  Wongnai iOS Assignment
//
//  Created by Suchaya K. on 9/1/2565 BE.
//

import UIKit
import UIColor_Hex_Swift

class ListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var keyLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var imgView: UIView!
    @IBOutlet weak var imgImgView: UIImageView!
    @IBOutlet weak var underLineView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setDisplay()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setDisplay() {
        keyLabel.textColor = UIColor("#1D1D1D")
        
        detailLabel.textColor = UIColor("#3F3F3F")
        detailLabel.numberOfLines = 0
        
        likeCountLabel.textColor = UIColor("#979797")
        
        imgView.layer.cornerRadius = 4
        imgView.clipsToBounds = true
        
        underLineView.backgroundColor = UIColor("#EEEEEE")
    }

}
