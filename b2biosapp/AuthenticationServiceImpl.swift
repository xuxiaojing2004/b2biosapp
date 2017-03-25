//
//  AuthenticationServiceImpl.swift
//  b2biosapp
//
//  Created by Xiaojing Xu on 3/19/17.
//  Copyright © 2017 jikesai. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthenticationServiceImpl : AuthenticationService {
    
    func ssoLogin(appLoginModel: AppLoginModel, completion: @escaping (Dictionary<String, Any>) -> Void) throws {
        
        let request = Alamofire.request(Constants.SSO_LOGIN, method: .post, parameters: appLoginModel.getAsParameters(), encoding: JSONEncoding.default)
        debugPrint(request)
        
        let preferences = UserDefaults.standard
        preferences.removeObject(forKey: Constants.TOKEN)
        
        request.responseJSON { response in
            
            print("headers \(response.response!.allHeaderFields)")
            print("cookies \(HTTPCookieStorage.shared.cookies)")
            
            var resultDict = Dictionary<String, Any>()
            if let jsonResultString = response.result.value {
                //print("public notice JSON: \(jsonResultString)")
                var json = JSON(jsonResultString)
                
                do {
                    print("json \(json)")
                    if let action = json["action"].string {
                        if action == "ok" {
                            let token = json["data"].string
                            resultDict[Constants.TOKEN] = token
                            
                            preferences.set(token, forKey: Constants.TOKEN)
                            preferences.set(appLoginModel.username, forKey:Constants.DEFAULT_USERNAME)
                        }
                    }
                    //self.validateSSOLogin(json: json)
                }  catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
            }
            completion(resultDict)
        }
        
    }
    
}
