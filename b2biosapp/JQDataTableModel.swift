//
//  JQDataTableModel.swift
//  b2biosapp
//
//  Created by Xiaojing Xu on 3/12/17.
//  Copyright © 2017 jikesai. All rights reserved.
//

import Foundation

class JQDataTableModel {
    
    public let IS_IN_SET  = "1";
    public let IS_BUNDARY = "1";
    public let NOT_BUNDARY = "0";
    public let IS_EQUAL = "1";
    public let PLAN_FIELD = "plan";
    public let DETAILS_FIELD = "details";
    
    /**
     * 查询计数
     */
    var  sEcho :String? {
        set { self.sEcho = newValue }
        get { return self.sEcho }
    }
    
    /**
     * 查询字段
     */
    var sFilter : [JQDataFilter]? {
        set { self.sFilter = newValue }
        get { return self.sFilter }
    }
    
    /**
     * not used reserved purpose
     * 查询字段
     */
    var sSearch : String? {
        set { self.sSearch = newValue }
        get { return self.sSearch }
    }
    
    /**
     * 分页起始点
     */
    var  iDisplayStart : String? {
        set { self.iDisplayStart = newValue }
        get { return self.iDisplayStart }
    }

    
    /**
     * 分页长度
     */
    var iDisplayLength : String? {
        set { self.iDisplayLength = newValue }
        get { return self.iDisplayLength }
    }

    
    /**
     * 顺序 ASC or DESC
     */
    var sSortDir_0 : String? {
        set { self.sSortDir_0 = newValue }
        get { return self.sSortDir_0 }
    }

    
    /**
     * 排序列
     */
    var iSortCol_0 : String? {
        set { self.iSortCol_0 = newValue }
        get { return self.iSortCol_0 }
    }

    
    /**
     * 排序字段
     */
    var sSortColField : String? {
        set { self.sSortColField = newValue }
        get { return self.sSortColField }
    }
    
}
