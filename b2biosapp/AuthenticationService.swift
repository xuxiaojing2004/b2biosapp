//
//  AuthenticationService.swift
//  b2biosapp
//
//  Created by Xiaojing Xu on 3/19/17.
//  Copyright © 2017 jikesai. All rights reserved.
//

import Foundation

protocol  AuthenticationService {
    
    func ssoLogin(appLoginModel: AppLoginModel, completion: @escaping (Dictionary<String, Any>) -> Void) throws
    
}
