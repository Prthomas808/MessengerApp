//
//  ReusableSystemImage.swift
//
//  Created by Pedro Thomas on 12/1/23.
//

import UIKit

class ReusableSystemImage: UIImageView {

  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(systemImage: String, preferMultiColor: Bool, color: UIColor?, height: CGFloat, width: CGFloat) {
    super.init(frame: .zero)
    self.image = UIImage(systemName: systemImage)
    
    if preferMultiColor {
      preferredSymbolConfiguration = .preferringMulticolor()
    } else {
      self.tintColor = color
    }
    
    NSLayoutConstraint.activate([
      self.heightAnchor.constraint(equalToConstant: height),
      self.widthAnchor.constraint(equalToConstant: width)
    ])
    
    configure()
  }
  
  private func configure() {
    translatesAutoresizingMaskIntoConstraints = false
  }
  
}
