import UIKit

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
    imageView.setImage(from: character.image)
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
    stackView.distribution = .equalSpacing
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
    imageView.contentMode = .scaleAspectFit
    title.numberOfLines = 0
    title.textAlignment = .center
  }
}
