//
//  PrivateMessageService.swift
//  b2biosapp
//
//  Created by Xiaojing Xu on 3/23/17.
//  Copyright © 2017 jikesai. All rights reserved.
//

import Foundation

protocol PrivateMessageService {
    
    func getById(id: Int, completion: @escaping (PrivateMessage?) -> Void) throws -> PrivateMessage?;
    
    func getByKey(key: String, completion: @escaping (PrivateMessage?) -> Void) throws -> PrivateMessage?;
    
    func getPrivateMessageFromRemote(dataModel: JQDataTableModel, completion: @escaping (Array<PrivateMessage>) -> Void)
    
}
