//
//  KeyStoreServiceImpl.swift
//  b2biosapp
//
//  Created by Xiaojing Xu on 3/12/17.
//  Copyright © 2017 jikesai. All rights reserved.
//

import Foundation
import CoreData

class KeyStoreServiceImpl: KeyStoreService {
    
    let managedContext = CoreDataManager.sharedInstance.persistentContainer.viewContext
    
    //find by uuid
    func getByKey(key: String) throws -> KeyStore? {
        let request: NSFetchRequest<KeyStore> = KeyStore.fetchRequest()
        
        request.predicate = NSPredicate(format:"key=%@", argumentArray: [key])
        let keyStores = try managedContext.fetch(request)
        print ("keyStore count:\(keyStores.count)")
        if keyStores.count > 0 {
            return keyStores[0];
        } else {
            return nil;
        }
    }
    
    //return a list of objects
    func getAll() throws -> [KeyStore]?  {
        let request: NSFetchRequest<KeyStore> = KeyStore.fetchRequest()
        
        let keyStores =  try managedContext.fetch(request)
        print ("keyStores count:\(keyStores.count)")
        return keyStores;
    }
    
    func save(keyStore: KeyStore) throws {
        try managedContext.save()
    }
    
    func update(keyStore: KeyStore) throws {
        try managedContext.save()
    }
    
    func delete(keyStore: KeyStore) throws {
        managedContext.delete(keyStore)
        try managedContext.save()
    }
    
    func deleteAll() throws {
        // Create Fetch Request
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "KeyStore")
        
        // Create Batch Delete Request
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        
        try managedContext.execute(batchDeleteRequest)
    }
    
}
