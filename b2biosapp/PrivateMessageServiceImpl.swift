//
//  PrivateMessageServiceImpl.swift
//  b2biosapp
//
//  Created by Xiaojing Xu on 3/23/17.
//  Copyright © 2017 jikesai. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class PrivateMessageServiceImpl: PrivateMessageService {
    
    let managedContext = CoreDataManager.sharedInstance.persistentContainer.viewContext
    
    var privateMessages = Array<PrivateMessage>()
    
    func getById(id: Int, completion: @escaping (PrivateMessage?) -> Void) throws -> PrivateMessage? {
        let url = Constants.GET_PRIVATE_MESSAGE_URL.replacingOccurrences(of: "{messageId}", with: String(id))
        
        let request = Alamofire.request(url, method: .get, encoding: JSONEncoding.default)
        debugPrint(request)
        
        request.responseJSON { response in
            if let jsonResultString = response.result.value {
                print("private message JSON: \(jsonResultString)")
                var json = JSON(jsonResultString)
                
                let privateMessage = self.populatePrivateMessage(json: json)
                completion(privateMessage)

            }
        }
        //TODo
        return nil
    }

    
    func getByKey(key: String, completion: @escaping (PrivateMessage?) -> Void) throws -> PrivateMessage? {
        print("TODO")
        return nil
    }
    
    func getPrivateMessageFromRemote(dataModel: JQDataTableModel, completion: @escaping (Array<PrivateMessage>) -> Void) {
     
        let configuration = URLSessionConfiguration.default
        let sessionManager = Alamofire.SessionManager(configuration: configuration)
        
        let request = Alamofire.request(Constants.GET_PRIVATE_MESSAGES_URL, method: .post, parameters: dataModel.getAsParameters(), encoding: JSONEncoding.default)
        debugPrint(request)
        
        request.responseJSON { response in
            if let jsonResultString = response.result.value {
                print("private message JSON: \(jsonResultString)")
                var json = JSON(jsonResultString)
                
                do {
                    self.populatePrivateMessages(json: json)
                }  catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
            }
            completion(self.privateMessages)
        }
        
    }
    
    private func populatePrivateMessages(json: JSON) -> Array<PrivateMessage> {
        if let action = json["action"].string {
            if action == "ok" {
                let list: Array<JSON> = json["data"].arrayValue
                for item in list{
                    let privateMessage = convertToPrivateMessage(item: item);
                    privateMessages.append(privateMessage)
                }
            }
            //Now you got your value
            print("Action:\(action) privateMessage count \(privateMessages.count)")
            
        }
        return privateMessages
    }
    
    private func populatePrivateMessage(json: JSON) -> PrivateMessage? {
        if let action = json["action"].string {
            if action == "ok" {
                let item = json["data"]
                let privateMessage = convertToPrivateMessage(item: item)
                return privateMessage
            }
        }
        return nil
    }
    
    private func convertToPrivateMessage(item: JSON) -> PrivateMessage {
        let privateMessage = PrivateMessage(context: self.managedContext)
        privateMessage.id = Int32(item["id"].intValue)
        privateMessage.uuid = nil
        privateMessage.sender = item["sender"].string
        privateMessage.category = item["category"].string
        privateMessage.subject  = item["subject"].string
        privateMessage.message = item["message"].string
        privateMessage.sendTime = item["sendTime"].string
        privateMessage.hasRead = (item["hasRead"].string != nil) && item["hasRead"] == "Y"
        return privateMessage
    }
    
}
