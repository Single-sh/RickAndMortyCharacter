import UIKit

class CharactersView: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
  enum Props {
    case beginLoading
    case loaded(Info, PageType)

    struct Info {
      let characters: [CharacterDTO]
      let onLoad: ((PageType) -> Void)?
      let onSelectCell: ((CharacterDTO) -> Void)
    }
  }

  var props: Props = .beginLoading
  var characters = [CharacterDTO]()
  
  func updateProps(_ props: Props) {
    self.props = props
    switch props {
    case let .loaded(info, type):
      switch type {
      case .next:
        characters += info.characters
      default:
        characters = info.characters
        collection.refreshControl?.endRefreshing()
      }
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
    collection.fillSuperview()
    collection.register(
      CharacterCollectionViewCell.self,
      forCellWithReuseIdentifier: String(describing: CharacterCollectionViewCell.self)
    )
    collection.dataSource = self
    collection.delegate = self

    let refresh = UIRefreshControl()
    refresh.addTarget(self, action: #selector(onRefresh), for: .valueChanged)
    collection.refreshControl = refresh
  }

  @objc private func onRefresh() {
    if case let .loaded(info, _) = props  {
      info.onLoad?(.refresh)
    }
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

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if case let .loaded(info, _) = props  {
      info.onSelectCell(characters[indexPath.row])
    }
  }

  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    let columns: CGFloat = traitCollection.horizontalSizeClass == .compact ? 2 : 4
    let width = (collection.bounds.width - columns * cellSpace - cellSpace) / columns
    let height = width + (width / 100 * 10)
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
    if currentOffset > height, case let .loaded(info, _) = props  {
      info.onLoad?(.next)
    }
  }

}
