//
//  AppLoginModel.swift
//  b2biosapp
//
//  Created by Xiaojing Xu on 3/19/17.
//  Copyright © 2017 jikesai. All rights reserved.
//

import Foundation
import Alamofire

class AppLoginModel {
    
    var clientId: String = "";

    var clientSecret: String = "";

    var username: String = "";

    var password: String = "";

    var clientIp: String = "";

    var url: String = "";
    
    func getAsParameters() -> Parameters {
        let parameters: Parameters = [
            "clientId": self.clientId,
            "clientSecret": self.clientSecret,
            "username": self.username,
            "password": self.password,
            "clientIp": self.clientIp,
            "url": self.url
        ]
        return parameters;
    }
    
}
