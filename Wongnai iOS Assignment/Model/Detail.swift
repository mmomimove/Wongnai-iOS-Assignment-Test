//
//  Detail.swift
//  Wongnai iOS Assignment
//
//  Created by Suchaya K. on 10/1/2565 BE.
//

import Foundation
import UIKit

struct Detail: Decodable{
    var name: String!
    var description: String!
    var positive_votes_count: Int32!
    var image_url: String!
    
    func countLike_string() -> String {
        let numFormat = NumberFormatter()
        numFormat.numberStyle = .decimal
        let numVote = numFormat.string(from: positive_votes_count as NSNumber) ?? ""
        return numVote
    }
}
