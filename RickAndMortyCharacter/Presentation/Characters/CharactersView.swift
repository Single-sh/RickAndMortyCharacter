import UIKit

class CharactersView: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
  enum Props {
    case beginLoading
    case loaded(Info)

    struct Info {
      let characters: [CharacterDTO]
      let onLoad: (() -> Void)?
    }
  }

  var props: Props = .beginLoading
  var characters = [CharacterDTO]()
  func updateProps(_ props: Props) {
    self.props = props
    switch props {
    case let .loaded(info):
      characters += info.characters
      collection.reloadData()
    default:
      return
    }
  }

  init() {
    super.init(frame: .zero)
    setupUI()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }

  private let cellSpace: CGFloat = 20
  private var collection = UICollectionView(
    frame: .zero,
    collectionViewLayout: UICollectionViewFlowLayout()
  )

  private func setupUI() {
    backgroundColor = .white
    collection.backgroundColor = .clear
    addSubview(collection)
    collection.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      collection.leadingAnchor.constraint(equalTo: readableContentGuide.leadingAnchor),
      collection.rightAnchor.constraint(equalTo: readableContentGuide.rightAnchor),
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
    characters.count
  }


  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: String(describing: CharacterCollectionViewCell.self),
      for: indexPath
    ) as! CharacterCollectionViewCell
    cell.setInfo(characters[indexPath.row])
    return cell
  }

  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    let columns: CGFloat = traitCollection.horizontalSizeClass == .compact ? 3 : 5
    let width = collection.frame.width / columns
    let height = width + (width / 100 * 30)
    return .init(width: width, height: height)
  }

  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    insetForSectionAt section: Int
  ) -> UIEdgeInsets {
    .init(top: cellSpace, left: cellSpace, bottom: cellSpace, right: cellSpace)
  }

  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    minimumLineSpacingForSectionAt section: Int
  ) -> CGFloat {
    cellSpace
  }

  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    minimumInteritemSpacingForSectionAt section: Int
  ) -> CGFloat {
    cellSpace
  }

  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let currentOffset = scrollView.contentOffset.y
    let height = scrollView.contentSize.height - scrollView.frame.size.height
    let maxScroll = height / 100 * 80
    if currentOffset > maxScroll, case let .loaded(info) = props  {
      info.onLoad?()
    }
  }

}
