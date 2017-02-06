//
//  ListingTableViewCell.swift
//  CoreDataWithAPI
//
//  Created by Vishwajeet Dagar on 2/4/17.
//  Copyright © 2017 Vishwajeet. All rights reserved.
//

import Foundation
import UIKit

class ListingTableViewCell: UITableViewCell {

    @IBOutlet weak var unitTypeText: UILabel!
    @IBOutlet weak var listingImageView: UIImageView!
    @IBOutlet weak var descriptionText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func highlightText(searchText: String, wholeText: String)
    {
        let coloredText = NSMutableAttributedString(string: wholeText)
        let colorAttribute = [ NSForegroundColorAttributeName: UIColor.blue ]
        coloredText.addAttributes(colorAttribute, range: (wholeText as NSString).range(of: searchText, options: NSString.CompareOptions.caseInsensitive))
        unitTypeText.attributedText = coloredText
    }

}
