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
  
  @objc func newMessageTapped() {
    let vc = NewMessageVC()
    let nav = UINavigationController(rootViewController: vc)
    present(nav, animated: true)
  }
  
  // MARK: Helping Functions
  private func configureNavBar() {
    title = "Conversations"
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.circle"), style: .plain, target: self, action: #selector(profileTapped))
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"), style: .plain, target: self, action: #selector(newMessageTapped))
  }

  private func authenticateUser() {
    AuthenticationManagers.shared.authenticateUser(view: self)
  }
}

