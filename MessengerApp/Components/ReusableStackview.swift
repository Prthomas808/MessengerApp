//
//  ReusableStackview.swift
//  MessengerApp
//
//  Created by Pedro Thomas on 12/27/23.
//

import UIKit

class ReusableStackview: UIStackView {

  // MARK: Lifecyle
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(distrubiton: UIStackView.Distribution, axis: NSLayoutConstraint.Axis, spacing: CGFloat, alignment: UIStackView.Alignment) {
    super.init(frame: .zero)
    self.distribution = distribution
    self.axis = axis
    self.spacing = spacing
    self.alignment = alignment
    configure()
  }
  
  // MARK: Helping Functions
  private func configure() {
    translatesAutoresizingMaskIntoConstraints = false
  }
}
