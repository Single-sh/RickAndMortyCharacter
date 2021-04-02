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

  func setInfo(_ character: CharacterDTO) {
    title.text = character.name
    setImage(from: character.image)
  }

  private func setupUI() {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.alignment = .fill
    stackView.distribution = .fillProportionally
    addSubview(stackView)
    stackView.fillSuperview()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    title.translatesAutoresizingMaskIntoConstraints = false
    stackView.addArrangedSubview(imageView)
    stackView.addArrangedSubview(title)

    title.numberOfLines = 0
    title.textAlignment = .center
  }

  private func setImage(from url: String) {
    guard let imageURL = URL(string: url) else { return }

    DispatchQueue.global().async {
      guard let imageData = try? Data(contentsOf: imageURL) else { return }

      let image = UIImage(data: imageData)
      DispatchQueue.main.async {
        self.imageView.image = image
      }
    }
  }
}
