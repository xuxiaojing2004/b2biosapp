//
//  VendorProduct+CoreDataProperties.swift
//  b2biosapp
//
//  Created by Xiaojing Xu on 3/10/17.
//  Copyright © 2017 jikesai. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension VendorProduct {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<VendorProduct> {
        return NSFetchRequest<VendorProduct>(entityName: "VendorProduct");
    }

    @NSManaged public var uuid: String?
    @NSManaged public var json: String?
    @NSManaged public var status: Int16
    @NSManaged public var id: Int64

}
