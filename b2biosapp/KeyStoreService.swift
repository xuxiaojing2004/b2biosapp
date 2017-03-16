//
//  KeyStoreService.swift
//  b2biosapp
//
//  Created by Xiaojing Xu on 3/12/17.
//  Copyright © 2017 jikesai. All rights reserved.
//

import Foundation
import CoreData

protocol KeyStoreService {
    
    //find by keyword
    func getByKey(key: String) throws -> KeyStore?;
    
    //return a list of objects
    func getAll() throws -> [KeyStore]?;
    
    func save(keyStore: KeyStore) throws;
    
    func update(keyStore: KeyStore) throws;
    
    func delete(keyStore: KeyStore) throws;
    
    func deleteAll() throws;
    
}
