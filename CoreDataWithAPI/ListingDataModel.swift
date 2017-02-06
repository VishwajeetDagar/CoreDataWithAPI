//
//  ListingDataModel.swift
//  CoreDataWithAPI
//
//  Created by Vishwajeet Dagar on 2/4/17.
//  Copyright © 2017 Vishwajeet. All rights reserved.
//

import UIKit

class ListingDataModel{
    
    //MARK: Properties
    var unitTypeText: String
    var photo: UIImage?
    var descriptionText: String?
    
    
    init?(unitTypeText: String, photo: UIImage?, descriptionText: String?) {
        
        if unitTypeText.isEmpty  {
            return nil
        }
        
        self.unitTypeText=unitTypeText
        
        if photo != nil{
            self.photo=photo
        }
        else{
            self.photo=#imageLiteral(resourceName: "blankImage")
        }
        
        if descriptionText != nil{
            self.descriptionText=descriptionText
        }
        else{
            self.descriptionText="No description available"
        }
    }
    
}
