//
//  Constants.swift
//  b2biosapp
//
//  Created by Xiaojing Xu on 3/12/17.
//  Copyright © 2017 jikesai. All rights reserved.
//

import Foundation

class Constants {
    
    public static let SERVER_BASE_URL = "http://localhost:8080/";
    
    public static let GET_EMART_MATERIAL_TYPE_URL = SERVER_BASE_URL + "public/emart/material_types/get.do"; //GET
    
    public static let GET_PUBLIC_NOTICES_URL = SERVER_BASE_URL + "public/notice.do"; //POST
    
    public static let GET_PUBLIC_NOTICE_URL = SERVER_BASE_URL + "public/notice/v2/{uuid}/get.do"; //GET
    
    public static let KEY_EMART_MATERIAL_TYPE = "KEY_EMART_MATERIAL_TYPE";
    
    //public static let KEY_PUBLIC_NOTICE = "KEY_PUBLIC_NOTICE";
    
}
