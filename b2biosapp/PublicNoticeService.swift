//
//  PublicNoticeService.swift
//  b2biosapp
//
//  Created by Xiaojing Xu on 3/16/17.
//  Copyright © 2017 jikesai. All rights reserved.
//

import Foundation

protocol PublicNoticeSevice {
    
    func getByKey(key: String) throws -> PublicNotice?;
    
    func getByPage(dataModel: JQDataTableModel) throws -> [PublicNotice]?;
    
}
