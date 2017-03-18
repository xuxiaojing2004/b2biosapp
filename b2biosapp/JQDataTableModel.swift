//
//  JQDataTableModel.swift
//  b2biosapp
//
//  Created by Xiaojing Xu on 3/12/17.
//  Copyright © 2017 jikesai. All rights reserved.
//

import Foundation
import Alamofire

class JQDataTableModel {
    
    public let IS_IN_SET  = "1";
    public let IS_BUNDARY = "1";
    public let NOT_BUNDARY = "0";
    public let IS_EQUAL = "1";
    
    func getAsParameters() -> Parameters {
        let parameters: Parameters = [
            "iDisplayStart": self.iDisplayStart!,
            "iDisplayLength": self.iDisplayLength!
        ]
        return parameters;
    }
    
    /**
     * 查询计数
     */
    var  sEcho :String?
    /**
     * 查询字段
     */
    var sFilter : [JQDataFilter]?
    /**
     * not used reserved purpose
     * 查询字段
     */
    var sSearch : String?
    
    /**
     * 分页起始点
     */
    var  iDisplayStart : String?
    
    /**
     * 分页长度
     */
    var iDisplayLength : String?
    
    /**
     * 顺序 ASC or DESC
     */
    var sSortDir_0 : String?
    
    /**
     * 排序列
     */
    var iSortCol_0 : String?
    
    /**
     * 排序字段
     */
    var sSortColField : String?    
}
