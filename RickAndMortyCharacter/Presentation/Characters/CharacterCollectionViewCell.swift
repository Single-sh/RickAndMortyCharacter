import UIKit
import Nuke

class CharacterCollectionViewCell: UICollectionViewCell {
  private let imageView = UIImageView()
  private let title = UILabel()

  override init(frame: CGRect) {
    super .init(frame: frame)
    setupUI()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    imageView.image = UIImage(named: "character")
  }

  func setInfo(_ character: CharacterDTO) {
    title.text = character.name
    Nuke.loadImage(with: URL(string: character.image)!, into: imageView)
  }

  private func setupUI() {
    let view = UIView()
    addSubview(view)
    view.fillSuperview()
    view.layer.shadowColor = UIColor.black.cgColor
    view.layer.shadowOpacity = 0.7
    view.layer.shadowOffset = .zero
    view.layer.shadowRadius = 2
    view.layer.cornerRadius = 10
    view.backgroundColor = .white

    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.distribution = .equalCentering
    view.addSubview(stackView)
    stackView.fillSuperview()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    title.translatesAutoresizingMaskIntoConstraints = false
    stackView.spacing = 5
    stackView.addArrangedSubview(imageView)
    stackView.addArrangedSubview(title)
    imageView.layer.cornerRadius = 10
    imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    imageView.layer.masksToBounds = true
    imageView.contentMode = .scaleAspectFill
    title.numberOfLines = 0
    title.textAlignment = .center
  }
}
