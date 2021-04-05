import Foundation
import UIKit

class DetailView: UIView {
  struct Props {
    let name: String
    let status: String
    let gender: String
    let species: String
    let imageUrl: String
  }

  func updateProps(_ props: Props) {
    nameLabel.text = "Name: \(props.name)"
    statusLabel.text = "Status: \(props.status)"
    genderLabel.text = "Gender: \(props.gender)"
    speciesLabel.text = "Species: \(props.species)"
    imageView.setImage(from: props.imageUrl)
  }

  init() {
    super.init(frame: .zero)
    setupUI()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }

  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    if traitCollection.horizontalSizeClass != previousTraitCollection?.horizontalSizeClass {
      enableConstraintsForWidth()
    }
  }

  private func enableConstraintsForWidth() {
    if traitCollection.horizontalSizeClass == .regular {
      headStack.axis = .horizontal
    } else {
      headStack.axis = .vertical
    }
  }

  private let headStack = UIStackView()
  private let imageView = UIImageView()
  private let nameLabel = UILabel()
  private let statusLabel = UILabel()
  private let genderLabel = UILabel()
  private let speciesLabel = UILabel()

  private func setupUI() {
    backgroundColor = .white
    headStack.translatesAutoresizingMaskIntoConstraints = false
    addSubview(headStack)
    NSLayoutConstraint.activate([
      headStack.leadingAnchor.constraint(equalTo: readableContentGuide.leadingAnchor),
      headStack.rightAnchor.constraint(equalTo: readableContentGuide.rightAnchor),
      headStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
      headStack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
    ])
    headStack.addArrangedSubview(imageView)
    headStack.spacing = 5
    headStack.distribution = .fillEqually
    let textStack = UIStackView()
    textStack.axis = .vertical
    headStack.addArrangedSubview(textStack)
    textStack.spacing = 5
    textStack.addArrangedSubview(nameLabel)
    textStack.addArrangedSubview(statusLabel)
    textStack.addArrangedSubview(genderLabel)
    textStack.addArrangedSubview(speciesLabel)
    imageView.contentMode = .scaleAspectFit
    textStack.distribution = .fillEqually
    enableConstraintsForWidth()
  }
}