//
//  User.swift
//  MessengerApp
//
//  Created by Pedro Thomas on 12/29/23.
//

import Foundation

struct User {
  let email: String
  let firstName: String
  let lastName: String
  let profilePicURL: String
  let uid: String
  
  init(dictionary: [String : Any]) {
    self.email = dictionary["email"] as? String ?? ""
    self.firstName = dictionary["firstName"] as? String ?? ""
    self.lastName = dictionary["lastName"] as? String ?? ""
    self.profilePicURL = dictionary["profilePicURL"] as? String ?? ""
    self.uid = dictionary["uid"] as? String ?? ""
  }
}
