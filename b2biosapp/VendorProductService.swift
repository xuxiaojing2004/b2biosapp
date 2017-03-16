//
//  VendorProductService.swift
//  b2biosapp
//
//  Created by Xiaojing Xu on 3/11/17.
//  Copyright © 2017 jikesai. All rights reserved.
//

import Foundation
import CoreData

protocol VendorProductService {
    
    //find by uuid
    func getByKey(key: String) throws -> VendorProduct?;
    
    //return a list of objects
    func getAll() throws -> [VendorProduct]?;
    
    func save(vendorProduct: VendorProduct) throws;
    
    func update(vendorProduct: VendorProduct) throws;
    
    func delete(vendorProduct: VendorProduct) throws;
    
    func deleteAll() throws;
    
}
