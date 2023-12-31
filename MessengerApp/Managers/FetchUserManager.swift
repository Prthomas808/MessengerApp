//
//  FetchUserManager.swift
//  MessengerApp
//
//  Created by Pedro Thomas on 12/29/23.
//

import Foundation
import Firebase

class FetchUserManager {
  
  static let shared = FetchUserManager()
  let fs = Firestore.firestore()
  
  func fetchUsers(completion: @escaping([User]) -> Void) {
    var users: [User] = []
    fs.collection("user").getDocuments { snapshot, error in
      snapshot?.documents.forEach({ snap in
        
        let dict = snap.data()
        let user = User(dictionary: dict)
        users.append(user)
        completion(users)
        
      })
    }
  }
  
}
