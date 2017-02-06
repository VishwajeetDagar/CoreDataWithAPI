//
//  NetworkUtil.swift
//  CoreDataWithAPI
//
//  Created by Vishwajeet Dagar on 2/4/17.
//  Copyright © 2017 Vishwajeet. All rights reserved.
//

import UIKit

class NetworkUtil{
    
   class func query(url:URL,networkClosure: @escaping (_ data: Data?)->()){
        
        let request=URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            if error != nil
            {
                print("Error while trying to connect to internet.")
            }
            networkClosure(data)
        }
        task.resume()
    }
}
