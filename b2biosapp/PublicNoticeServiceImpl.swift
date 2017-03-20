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
    func getByKey(key: String, completion: @escaping (PublicNotice?) -> Void) throws -> PublicNotice? {
        let url = Constants.GET_PUBLIC_NOTICE_URL.replacingOccurrences(of: "{uuid}", with: key)
        
        print("call \(url)")
        let request = Alamofire.request(url, method: .get)
        debugPrint(request)
        
        request.responseJSON{ response in
            if let jsonResultString = response.result.value {
                let json = JSON(jsonResultString)
                
                let publicNotice = self.populatePublicNotice(json: json)
                
                completion(publicNotice)
            }
        }
        //TODO
        return nil
    }
    
    func getByPage(dataModel: JQDataTableModel) throws -> [PublicNotice]? {
        getPublicNoticeFromRemote(dataModel: dataModel) {
            (result) in
                print("\(result.count)")
        }
        
        return publicNotices
        
    }
    
    func getPublicNoticeFromRemote(dataModel: JQDataTableModel, completion: @escaping (Array<PublicNotice>) -> Void) {
        let request = Alamofire.request(Constants.GET_PUBLIC_NOTICES_URL, method: .post, parameters: dataModel.getAsParameters(), encoding: JSONEncoding.default)
        debugPrint(request)
        
        request.responseJSON { response in
            if let jsonResultString = response.result.value {
                //print("public notice JSON: \(jsonResultString)")
                var json = JSON(jsonResultString)
                
                do {
                    self.populatePublicNotices(json: json)
                }  catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
            }
            completion(self.publicNotices)
        }
    }
    
    private func populatePublicNotice(json: JSON) -> PublicNotice? {
        if let action = json["action"].string {
            if action == "ok" {
                let item = json["data"]
                let publicNotice = convertToPublicNotice(item: item)
                return publicNotice
            }
        }
        return nil
    }
    
    private func populatePublicNotices(json: JSON) -> Array<PublicNotice> {
        
        if let action = json["action"].string {
            if action == "ok" {
                let list: Array<JSON> = json["data"].arrayValue
                for item in list{
                    let publicNotice = convertToPublicNotice(item: item);
                    publicNotices.append(publicNotice)
                }
            }
            //Now you got your value
            print("Action:\(action) publicNotice count \(publicNotices.count)")
            
        }
        return publicNotices
    }
    
    private func convertToPublicNotice(item: JSON) -> PublicNotice {
        let publicNotice = PublicNotice(context: self.managedContext)
        publicNotice.id = Int32(item["id"].intValue)
        publicNotice.uuid = item["uuid"].string
        publicNotice.noticeType = item["noticeType"].string
        publicNotice.subject = item["subject"].string
        publicNotice.content  = item["content"].string
        publicNotice.author = item["author"].string
        publicNotice.publishDate = item["publishDate"].string
        return publicNotice
    }
    
    private func isExpired(keyStore: KeyStore) -> Bool {
        return false; //TODO
    }

}
