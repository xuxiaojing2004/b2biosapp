//
//  GenericService.swift
//  b2biosapp
//
//  Created by Xiaojing Xu on 3/11/17.
//  Copyright © 2017 jikesai. All rights reserved.
//

import Foundation
import CoreData

class GenericDataService<T> {
    
    //find by uuid
    func getByKey<T>(_ key: String) -> T? {
        return nil;
    }
    
    //return a list of objects
    func getAll<T>() -> [T]? {
        return nil;
    }
    
}
