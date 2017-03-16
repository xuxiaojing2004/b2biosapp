//
//  VendorProductServiceImpl.swift
//  b2biosapp
//
//  Created by Xiaojing Xu on 3/11/17.
//  Copyright © 2017 jikesai. All rights reserved.
//

import Foundation
import CoreData

class VendorProductServiceImpl: VendorProductService {
    
    let managedContext = CoreDataManager.sharedInstance.persistentContainer.viewContext
    
    //find by uuid
    func getByKey(key: String) throws -> VendorProduct? {
        let request: NSFetchRequest<VendorProduct> = VendorProduct.fetchRequest()
        
        request.predicate = NSPredicate(format:"uuid=%@", argumentArray: [key])
        let vendorProducts = try managedContext.fetch(request)
        print ("vendorProduct count:\(vendorProducts.count)")
        if vendorProducts.count > 0 {
            return vendorProducts[0];
        } else {
            return nil;
        }
    }
    
    //return a list of objects
    func getAll() throws -> [VendorProduct]?  {
        let request: NSFetchRequest<VendorProduct> = VendorProduct.fetchRequest()
    
        let vendorProducts =  try managedContext.fetch(request)
        print ("vendorProduct count:\(vendorProducts.count)")
        return vendorProducts;
    }
    
    func save(vendorProduct: VendorProduct) throws {
        try managedContext.save()
    }
    
    func update(vendorProduct: VendorProduct) throws {
        try managedContext.save()
    }
    
    func delete(vendorProduct: VendorProduct) throws {
        managedContext.delete(vendorProduct)
        try managedContext.save()
    }
    
    func deleteAll() throws {
        // Create Fetch Request
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "VendorProduct")
        
        // Create Batch Delete Request
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: request)
       
        try managedContext.execute(batchDeleteRequest)
    }
    
}
