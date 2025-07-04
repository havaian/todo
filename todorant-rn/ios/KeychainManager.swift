//
//  KeychainManager.swift
//  Todomaster
//
//  Created by Nikita Kolmogorov on 2020-03-20.
//  Copyright © 2020 Facebook. All rights reserved.
//

import Foundation

let keychainWrapper = KeychainWrapper(
  serviceName: "todomaster",
  accessGroup: "ACWP4F58HZ.com.todomaster.app"
)

@objc(KeychainManager)
class KeychainManager: NSObject {
  
  let tokenSender = TokenSender()
  
  @objc(setToken:)
  func setToken(token: String) -> Void {
    keychainWrapper.set(token, forKey: "accessToken")
    self.tokenSender.session.sendMessage(["accessToken": token], replyHandler: nil) { (error) in
      print(error.localizedDescription)
    }
  }
  
  @objc
  func removeToken() -> Void {
    keychainWrapper.removeObject(forKey: "accessToken")
    self.tokenSender.session.sendMessage(["accessToken": "delete"], replyHandler: nil) { (error) in
      print(error.localizedDescription)
    }
  }
  
  @objc(setPassword:)
  func setPassword(password: String) -> Void {
    keychainWrapper.set(password, forKey: "password")
    self.tokenSender.session.sendMessage(["password": password], replyHandler: nil) { (error) in
      print(error.localizedDescription)
    }
  }
  
  @objc
  func removePassword() -> Void {
    keychainWrapper.removeObject(forKey: "password")
    self.tokenSender.session.sendMessage(["password": "delete"], replyHandler: nil) { (error) in
      print(error.localizedDescription)
    }
  }
  
  @objc
  static func requiresMainQueueSetup() -> Bool {
    return true
  }
}
