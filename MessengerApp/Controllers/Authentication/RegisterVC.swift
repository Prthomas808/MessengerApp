//
//  RegisterVC.swift
//  MessengerApp
//
//  Created by Pedro Thomas on 12/27/23.
//

import UIKit
import Firebase
import FirebaseStorage

class RegisterVC: UIViewController {

  // MARK: Properties
  private let ProfileImageButton = ReusableButton(buttonTitle: "Add Photo", textColor: .label, buttonColor: .systemGray6, height: 140, width: 140)
  private var profilePic: UIImage?
  
  private let textfieldStackview = ReusableStackview(distrubiton: .fill, axis: .vertical, spacing: 20, alignment: .center)
  private let firstNameTextfild = ReusableTextfield(placeholder: "First Name", keyboardType: .asciiCapable, isSecure: false, height: 50, width: UIScreen.main.bounds.width / 1.2)
  private let lastNameTextfild = ReusableTextfield(placeholder: "Last Name", keyboardType: .asciiCapable, isSecure: false, height: 50, width: UIScreen.main.bounds.width / 1.2)
  private let emailTextfild = ReusableTextfield(placeholder: "E-mail Address", keyboardType: .emailAddress, isSecure: false, height: 50, width: UIScreen.main.bounds.width / 1.2)
  private let passwordTextfild = ReusableTextfield(placeholder: "Password", keyboardType: .asciiCapable, isSecure: true, height: 50, width: UIScreen.main.bounds.width / 1.2)
  private let signUpButton = ReusableButton(buttonTitle: "Sign Up", textColor: .black, buttonColor: .systemGreen, height: 50, width: UIScreen.main.bounds.width / 1.2)
  
  private let currentUserStackView = ReusableStackview(distrubiton: .fill, axis: .horizontal, spacing: 0, alignment: .center)
  private let currentUserLabel = ReusableLabel(text: "Have An Account?", fontSize: 16, weight: .semibold, color: .label, numberOfLines: 0)
  private let logInHereButton = ReusableButton(buttonTitle: "Log In", textColor: .lightGray, buttonColor: .clear, height: nil, width: 60)
  
  // MARK: Lifecyle
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    navigationController?.isNavigationBarHidden = true
    configureProperties()
    configureConstraints()
  }
  
  // MARK: Objc Functions
  @objc func addProfilePicTapped() {
    let imagePicker = UIImagePickerController()
    imagePicker.delegate = self
    present(imagePicker, animated: true)
  }
  
  @objc func signUpTapped() {
    guard let profilePic = profilePic?.jpegData(compressionQuality: 0.3) else { return }
    guard let firstName = firstNameTextfild.text else { return }
    guard let lastName = lastNameTextfild.text else { return }
    guard let email = emailTextfild.text else { return }
    guard let password = passwordTextfild.text else { return }
    
    if firstName.isEmpty || lastName.isEmpty || email.isEmpty || password.isEmpty {
      presentAlert(title: "🟣 Error 🟣", message: "We couldn't sign you up", buttonTitle: "Try Again")
      return
    }
    
   
    AuthenticationManagers.shared.createUser(firstName: firstName, lastName: lastName, email: email, password: password, profilePic: profilePic, view: self)
    
  }
  
  @objc func logInTapped() {
    navigationController?.popViewController(animated: true)
  }
  
  // MARK: Helping Functions
  private func configureProperties() {
    view.addSubview(ProfileImageButton)
    let tap = UITapGestureRecognizer(target: self, action: #selector(addProfilePicTapped))
    ProfileImageButton.addGestureRecognizer(tap)
    ProfileImageButton.imageView?.contentMode = .scaleAspectFill
    ProfileImageButton.layer.cornerRadius = 140 / 2
    
    view.addSubview(textfieldStackview)
    textfieldStackview.addArrangedSubview(firstNameTextfild)
    textfieldStackview.addArrangedSubview(lastNameTextfild)
    textfieldStackview.addArrangedSubview(emailTextfild)
    textfieldStackview.addArrangedSubview(passwordTextfild)
    textfieldStackview.addArrangedSubview(signUpButton)
    
    view.addSubview(currentUserStackView)
    currentUserStackView.addArrangedSubview(currentUserLabel)
    currentUserStackView.addArrangedSubview(logInHereButton)
    
    // MARK: Button Targets
    signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
    logInHereButton.addTarget(self, action: #selector(logInTapped), for: .touchUpInside)
  }
  
  private func configureConstraints() {
    // ProfileImageButton constraints
    NSLayoutConstraint.activate([
      ProfileImageButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
      ProfileImageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ])
    
    //textfieldStackview
    NSLayoutConstraint.activate([
      textfieldStackview.topAnchor.constraint(equalTo: ProfileImageButton.bottomAnchor, constant: 15),
      textfieldStackview.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ])
    
    //currentUserStackView
    NSLayoutConstraint.activate([
      currentUserStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5),
      currentUserStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ])
  }
}

extension RegisterVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    let image = info[.originalImage] as? UIImage
    profilePic = image
    ProfileImageButton.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
    ProfileImageButton.layer.borderColor = UIColor.systemGreen.cgColor
    ProfileImageButton.layer.borderWidth = 3
    ProfileImageButton.layer.cornerRadius = 140 / 2
    dismiss(animated: true)
  }
}
