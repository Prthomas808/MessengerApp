//
//  LoginVC.swift
//  MessengerApp
//
//  Created by Pedro Thomas on 12/27/23.
//

import UIKit
import Firebase

class LoginVC: UIViewController {

  // MARK: Properties
  private let headerStackView = ReusableStackview(distrubiton: .fill, axis: .vertical, spacing: 10, alignment: .center)
  private let logoImageView = ReusableSystemImage(systemImage: "bubble.right", preferMultiColor: false, color: .systemPurple, height: 125, width: 125)
  private let taskLabel = ReusableLabel(text: "Sign In", fontSize: 18, weight: .bold, color: .label, numberOfLines: 0)
  private let instructionsLabel = ReusableLabel(text: "Enter Your Information below", fontSize: 14, weight: .light, color: .label, numberOfLines: 0)
  
  private let textfieldStackView = ReusableStackview(distrubiton: .fill, axis: .vertical, spacing: 20, alignment: .center)
  private let emailTextfield = ReusableTextfield(placeholder: "E-mail Address", keyboardType: .asciiCapable, isSecure: false, height: 50, width: UIScreen.main.bounds.width / 1.2)
  private let passwordTextfield = ReusableTextfield(placeholder: "Password", keyboardType: .asciiCapable, isSecure: true, height: 50, width: UIScreen.main.bounds.width / 1.2)
  private let signInButton = ReusableButton(buttonTitle: "Sign In", textColor: .black, buttonColor: .systemPurple, height: 50, width: UIScreen.main.bounds.width / 1.2)
  
  private let newUserStackView = ReusableStackview(distrubiton: .fill, axis: .horizontal, spacing: 5, alignment: .center)
  private let newUserLabel = ReusableLabel(text: "New User?", fontSize: 16, weight: .semibold, color: .label, numberOfLines: 0)
  private let createAccountButton = ReusableButton(buttonTitle: "Create Account", textColor: .lightGray, buttonColor: .clear, height: nil, width: 125)
  
  // MARK: Lifecyle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    configureProperties()
    configureConstraints()
  }
  
  // MARK: Objc Functions
  @objc func signInTapped() {
    guard let email = emailTextfield.text else { return }
    guard let password = passwordTextfield.text else { return }

    if email.isEmpty && password.isEmpty {
      presentAlert(title: "🟣 Error 🟣", message: "We had trouble signing you in", buttonTitle: "Try Again")
      return
    }
    
    showLoader(show: true, withText: "Logging In")
    AuthenticationManagers.shared.signIn(email: email, password: password, vc: self)
    showLoader(show: false, withText: "Logging In")
  }
  
  @objc func createAccountTapped() {
    let vc = RegisterVC()
    navigationController?.pushViewController(vc, animated: true)
  }
  
  // MARK: Helping Functions
  private func configureProperties() {
    view.addSubview(headerStackView)
    headerStackView.addArrangedSubview(logoImageView)
    headerStackView.addArrangedSubview(taskLabel)
    headerStackView.addArrangedSubview(instructionsLabel)
    
    view.addSubview(textfieldStackView)
    textfieldStackView.addArrangedSubview(emailTextfield)
    textfieldStackView.addArrangedSubview(passwordTextfield)
    textfieldStackView.addArrangedSubview(signInButton)
    
    view.addSubview(newUserStackView)
    newUserStackView.addArrangedSubview(newUserLabel)
    newUserStackView.addArrangedSubview(createAccountButton)
    
    // MARK: Button Targets
    signInButton.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
    createAccountButton.addTarget(self, action: #selector(createAccountTapped), for: .touchUpInside)
  }
  
  private func configureConstraints() {
    // headerStackView constraints
    NSLayoutConstraint.activate([
      headerStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      headerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
    ])
    
    // textfieldStackView constraints
    NSLayoutConstraint.activate([
      textfieldStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      textfieldStackView.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 10),
    ])
    
    // newUserStackView constraints
    NSLayoutConstraint.activate([
      newUserStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      newUserStackView.topAnchor.constraint(equalTo: textfieldStackView.bottomAnchor, constant: 10),
    ])
  }
}
