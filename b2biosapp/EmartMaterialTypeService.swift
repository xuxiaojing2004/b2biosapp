//
//  EmartMaterialTypeService.swift
//  b2biosapp
//
//  Created by Xiaojing Xu on 3/16/17.
//  Copyright © 2017 jikesai. All rights reserved.
//

import Foundation


protocol EmartMaterialTypeService {
    
    //find by uuid
    func getByKey(key: String) throws -> EmartMaterialTypeModel?;
    
    //return a list of objects
    func getAll() throws -> [EmartMaterialTypeModel]?;
    
}
