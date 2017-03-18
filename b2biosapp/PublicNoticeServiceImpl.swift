//
//  PublicNoticeServiceImpl.swift
//  b2biosapp
//
//  Created by Xiaojing Xu on 3/16/17.
//  Copyright © 2017 jikesai. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class PublicNoticeServiceImpl : PublicNoticeSevice {
    
    let managedContext = CoreDataManager.sharedInstance.persistentContainer.viewContext
    
    var publicNotices = Array<PublicNotice>()
    
    //find by uuid
    func getByKey(key: String) throws -> PublicNotice? {
        //TODO
        return nil
    }
    
    func getByPage(dataModel: JQDataTableModel) throws -> [PublicNotice]? {
        do {
            var json : JSON = nil
            
            let request = Alamofire.request(Constants.GET_PUBLIC_NOTICES_URL, method: .post, parameters: dataModel.getAsParameters(), encoding: JSONEncoding.default)
            debugPrint(request)
            
            request.responseJSON { response in
                if let jsonResultString = response.result.value {
                    //print("public notice JSON: \(jsonResultString)")
                    json = JSON(jsonResultString)
                        
                    do {
                    }  catch let error as NSError {
                        print("Could not save. \(error), \(error.userInfo)")
                    }
                }
            }            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }

        return nil;
    }
    
    private func populatePublicNoticeJson(json: JSON) -> Array<PublicNotice> {
        
        if let action = json["action"].string {
            if action == "ok" {
                let list: Array<JSON> = json["data"].arrayValue
                for item in list{
                    let publicNotice = PublicNotice()
                    publicNotice.id = Int32(item["id"].intValue)
                    publicNotice.noticeType = item["noticeType"].string
                    publicNotice.subject = item["subject"].string
                    publicNotice.content  = item["content"].string
                    publicNotice.author = item["author"].string
                    publicNotice.publishDate = item["publishDate"].string
                    publicNotices.append(publicNotice)
                }
            }
            //Now you got your value
            print("Action:\(action) publicNotice count \(publicNotices.count)")
            
        }
        return publicNotices
    }

    
    private func isExpired(keyStore: KeyStore) -> Bool {
        return false; //TODO
    }

}
