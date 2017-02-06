//
//  Listing+CoreDataClass.swift
//  CoreDataWithAPI
//
//  Created by Vishwajeet Dagar on 2/4/17.
//  Copyright © 2017 Vishwajeet. All rights reserved.
//

import Foundation
import CoreData

@objc(Listing)
public class Listing: NSManagedObject {

    class func getEntity(context: NSManagedObjectContext) -> NSEntityDescription{
        return NSEntityDescription.entity(forEntityName: "Listing", in: context)!
    }
    
}
