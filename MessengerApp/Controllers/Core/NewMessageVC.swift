//
//  NewMessageVC.swift
//  MessengerApp
//
//  Created by Pedro Thomas on 12/29/23.
//

import UIKit

class NewMessageVC: UIViewController {

  // MARK: Properties
  private var users: [User] = []
  private let contactTable = UITableView()
  
  // MARK: Lifecyle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    configureNavBar()
    configureContactTable()
    fetchUsers()
  }
  
  // MARK: Objc Functions
  @objc func dismissVC() {
    dismiss(animated: true)
  }
  
  // MARK: Helping Functions
  private func configureNavBar() {
    title = "New Message"
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissVC))
  }
  
  private func configureContactTable() {
    view.addSubview(contactTable)
    contactTable.delegate = self
    contactTable.dataSource = self
    contactTable.rowHeight = 75
    contactTable.register(ContactCell.self, forCellReuseIdentifier: ContactCell.reusableID)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    contactTable.frame = view.bounds
  }
  
  private func fetchUsers() {
    FetchUserManager.shared.fetchUsers { user in
      self.users = user
      self.contactTable.reloadData()
    }
  }
}

extension NewMessageVC: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    users.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard  let cell = tableView.dequeueReusableCell(withIdentifier: ContactCell.reusableID, for: indexPath) as? ContactCell else {
      return UITableViewCell()
    }
    cell.user = users[indexPath.row]
    return cell
  }
}
