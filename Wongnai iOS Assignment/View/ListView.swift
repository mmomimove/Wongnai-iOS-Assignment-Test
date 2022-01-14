//
//  ListView.swift
//  Wongnai iOS Assignment
//
//  Created by Suchaya K. on 12/1/2565 BE.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage
import SystemConfiguration

class ListView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var valueTableView: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit(){
        Bundle.main.loadNibNamed("ListView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        
    }
    
}

