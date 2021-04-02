import UIKit

class CharactersView: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
  enum Props {
    case initial
    case loading
    case loaded(Info)

    struct Info {
      struct Button {
        let enabled: Bool
        let onTap: () -> ()
      }

      let pages: Int
      let characters: [CharacterDTO]
      let nextPages: Button
      let previous: Button
    }
  }

  var props: Props = .initial
  func updateProps(_ props: Props) {
    self.props = props
    collection.reloadData()
  }
  override func layoutSubviews() {
    super.layoutSubviews()
    switch props {
    case .initial:
      setupUI()
    default:
      return
    }
  }

  private let collection = UICollectionView(
    frame: .zero,
    collectionViewLayout: UICollectionViewFlowLayout()
  )

  private func setupUI() {
    collection.backgroundColor = .white
    addSubview(collection)
    collection.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      collection.leadingAnchor.constraint(equalTo: leadingAnchor),
      collection.rightAnchor.constraint(equalTo: rightAnchor),
      collection.topAnchor.constraint(equalTo: topAnchor),
      collection.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
    collection.register(
      CharacterCollectionViewCell.self,
      forCellWithReuseIdentifier: String(describing: CharacterCollectionViewCell.self)
    )
    collection.dataSource = self
    collection.delegate = self
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if case let .loaded(info) = props {
      return info.characters.count
    }
    return 0
  }


  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    if case let .loaded(info) = props{
      let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: String(describing: CharacterCollectionViewCell.self),
        for: indexPath
      ) as! CharacterCollectionViewCell
      cell.setInfo(info.characters[indexPath.row])
      return cell
    }
    return UICollectionViewCell()
  }

  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    return .init(width: 200, height: 200)
  }

}
