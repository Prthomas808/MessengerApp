//
//  AuthenticationManagers.swift
//  MessengerApp
//
//  Created by Pedro Thomas on 12/28/23.
//

import UIKit
import Firebase
import FirebaseStorage
import JGProgressHUD

class AuthenticationManagers {
  
  static let shared = AuthenticationManagers()
  
  // MARK: SIGN IN
  func signIn(email: String, password: String, vc: UIViewController) {
    
    Auth.auth().signIn(withEmail: email, password: password) { result, error in
      if let error = error {
        print(" 🚨 ERROR: Failed to log user in \(error.localizedDescription)")
        return
      }
  
      vc.dismiss(animated: true)
    }
  }
  
  // MARK: CREATE USER
  func createUser(firstName: String, lastName: String, email: String, password: String, profilePic: Data, view: UIViewController) {
    let fileName = NSUUID().uuidString
    let ref = Storage.storage().reference(withPath: "/profile_images/\(fileName)")
    
    ref.putData(profilePic) { meta, error in
      if let error = error {
        print(" 🚨 ERROR: Failed to upload picture \(error.localizedDescription)")
        return
      }
      
      ref.downloadURL { url, error in
        guard let profilePicURL = url?.absoluteString else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
          if let error = error {
            print(" 🚨 ERROR: Could not create user \(error.localizedDescription)")
            return
          }
          
          guard let uid = result?.user.uid else { return }
          
          let data = [
            "profilePicURL": profilePicURL,
            "firstName": firstName,
            "lastName": lastName,
            "email": email,
            "uid": uid] as [String : AnyObject]
          
          Firestore.firestore().collection("user").document(uid).setData(data) { error in
            if let error = error {
              print(" 🚨 ERROR: Could not create user \(error.localizedDescription)")
              return
            }
            
            print("User; \(firstName) \(lastName) has been created")
            view.dismiss(animated: true)
          }
        }
      }
    }
  }
  
  // MARK: SIGN OUT
  func signOut() {
    do {
      try Auth.auth().signOut()
    } catch {
      print("Could not sign user out")
    }
  }
  
  // MARK: AUTHENTICATE USER
  func authenticateUser(view: UIViewController) {
    if Auth.auth().currentUser?.uid == nil {
      presentLogIn(view: view)
    } else {
      print("User is logged in")
    }
  }
  
  // MARK: PRESENT LOGIN SCREEN
  func presentLogIn(view: UIViewController) {
    DispatchQueue.main.async {
      let vc = LoginVC()
      let nav = UINavigationController(rootViewController: vc)
      nav.modalPresentationStyle = .fullScreen
      view.present(nav, animated: true)
    }
  }
  
  // MARK: Authenticatin Progress View
}


