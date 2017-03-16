//
//  JQDataFilter.swift
//  b2biosapp
//
//  Created by Xiaojing Xu on 3/12/17.
//  Copyright © 2017 jikesai. All rights reserved.
//

import Foundation

class JQDataFilter {
    
    var field : String? {
        set { self.field = newValue }
        get { return self.field }
    };
    var value : String? {
        set { self.value = newValue }
        get { return self.value }
    }
    var isFieldBundary: String? {
        set { self.isFieldBundary = newValue }
        get { return self.isFieldBundary }
    }
    var leftValue: String? {
        set { self.leftValue = newValue }
        get { return self.leftValue }
    }
    var rightValue: String? {
        set { self.rightValue = newValue }
        get { return self.rightValue }
    }
    var isIntSet : String? {
        set { self.isIntSet = newValue }
        get { return self.rightValue }
    }
    var isEqualTo : String? {
        set { self.isEqualTo = newValue }
        get { return self.isEqualTo }
    }
}
