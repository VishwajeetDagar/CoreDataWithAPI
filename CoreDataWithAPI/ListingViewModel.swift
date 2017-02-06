//
//  ListingViewModel.swift
//  CoreDataWithAPI
//
//  Created by Vishwajeet Dagar on 2/4/17.
//  Copyright © 2017 Vishwajeet. All rights reserved.
//

import Foundation
import UIKit

class ListingViewModel{
    
    class func getListings(){
        if let url=URL(string: "https://www.makaan.com/shade/app/v1/serp/buy?paging=1,20"){

            DispatchQueue.global(qos: .utility).async {
                NetworkUtil.query(url: url, networkClosure: { (data: Data?) in
                    do{
                        if data != nil{
                            if let jsonData = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: AnyObject]{
                                if let miscData = jsonData["data"] as? [String: Any]  {
                                    if let listings = miscData["listings"] as? [[String: AnyObject]]{
                                        for listing in listings{
                                            
                                            let imageUrlString = listing["mainImageUrl"]
                                            let imageUrl:URL = URL(string: imageUrlString as! String)!
                                            let imageData:NSData = NSData(contentsOf: imageUrl)!
                                            
                                            let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                            let managedContext = appDelegate.persistentContainer.viewContext
                                            let record = Listing(entity: Listing.getEntity(context: managedContext), insertInto: managedContext)
                                            record.unit = listing["unitTypeText"] as? String
                                            record.desc = listing["description"] as? String
                                            record.image = imageData
                                            
                                            appDelegate.saveContext()

                                        }
                                    }
                                }
                                
                            }
                        }
                    }
                    catch let error as NSError {
                        print("Error found\(error.localizedDescription)")
                    }
                })
            }
        }
    }
}

