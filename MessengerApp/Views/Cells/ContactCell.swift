//
//  ContactCell.swift
//  MessengerApp
//
//  Created by Pedro Thomas on 12/29/23.
//

import UIKit
import SDWebImage

class ContactCell: UITableViewCell {

  // MARK: Properties
  static let reusableID = "ContactCell"
  
  var user: User? {
    didSet { configure() }
  }
  
  private let contactImage = UIImageView()
  private let contactName = ReusableLabel(text: "Contact Name", fontSize: 14, weight: .regular, color: .label, numberOfLines: 0)
  // MARK: Lifecyle
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    configureProperties()
    constraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: Helping Functions
  private func configureProperties() {
    self.addSubview(contactImage)
    contactImage.backgroundColor = .systemGreen
    contactImage.contentMode = .scaleAspectFill
    contactImage.clipsToBounds = false
    contactImage.layer.masksToBounds = true
    contactImage.layer.cornerRadius = 50 / 2
    contactImage.translatesAutoresizingMaskIntoConstraints = false
    
    self.addSubview(contactName)
  }
  
  private func constraints() {
    // contactImage constraints
    NSLayoutConstraint.activate([
      contactImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
      contactImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      contactImage.heightAnchor.constraint(equalToConstant: 50),
      contactImage.widthAnchor.constraint(equalToConstant: 50),
    ])
    
    // contactName constraints
    NSLayoutConstraint.activate([
      contactName.leadingAnchor.constraint(equalTo: contactImage.trailingAnchor, constant: 5),
      contactName.centerYAnchor.constraint(equalTo: contactImage.centerYAnchor)
    ])
  }

  public func configure() {
    guard let user = user else { return }
    guard let profilePic = URL(string: user.profilePicURL) else { return }
    
    contactName.text = "\(user.firstName) \(user.lastName)"
    contactImage.sd_setImage(with: profilePic)
  }
}
