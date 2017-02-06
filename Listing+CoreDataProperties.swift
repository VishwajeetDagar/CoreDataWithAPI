//
//  Listing+CoreDataProperties.swift
//  CoreDataWithAPI
//
//  Created by Vishwajeet Dagar on 2/6/17.
//  Copyright © 2017 Vishwajeet. All rights reserved.
//

import Foundation
import CoreData


extension Listing {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Listing> {
        return NSFetchRequest<Listing>(entityName: "Listing");
    }

    @NSManaged public var desc: String?
    @NSManaged public var unit: String?
    @NSManaged public var image: NSData?

}
