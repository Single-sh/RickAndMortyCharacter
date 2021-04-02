import UIKit

extension UIView {
  func fillSuperview(padding: CGFloat = 0) {
    fillSuperview(insets: .init(top: padding, left: padding, bottom: padding, right: padding))
  }

  func fillSuperview(insets: UIEdgeInsets) {
    guard let superview = superview else {
      fatalError("View should be added to superview before settings constraints")
    }
    translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: insets.left),
      trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -insets.right),
      topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.top),
      bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -insets.bottom)
    ])
  }
}
