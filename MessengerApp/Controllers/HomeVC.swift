//
//  HomeVC.swift
//  MessengerApp
//
//  Created by Pedro Thomas on 12/27/23.
//

import UIKit
import Firebase

class HomeVC: UIViewController {

  // MARK: Properties
  
  
  // MARK: Lifecyle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    configureNavBar()
    authenticateUser()
  }
  
  // MARK: Objc Functions
  @objc func profileTapped() {
    AuthenticationManagers.shared.signOut()
    AuthenticationManagers.shared.presentLogIn(view: self)
  }
  
  // MARK: Helping Functions
  private func configureNavBar() {
    title = "Conversations"
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationController?.navigationBar.tintColor = .systemPurple
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.circle"), style: .plain, target: self, action: #selector(profileTapped))
  }

  private func authenticateUser() {
    AuthenticationManagers.shared.authenticateUser(view: self)
  }
}

