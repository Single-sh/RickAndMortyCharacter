import UIKit
import Moya

class CharactersViewController: BaseViewController {
  private let contentView = CharactersView()
  private let model: CharactersModelDelegate

  init(model: CharactersModelDelegate) {
    self.model = model
    super.init()
  }

  override func loadView() {
    view = contentView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    nextPage(.refresh)
  }

  override func viewWillAppear(_ animated: Bool) {
    navigationController?.setNavigationBarHidden(true, animated: animated)
    super.viewWillAppear(animated)
  }

  override func viewWillDisappear(_ animated: Bool) {
    navigationController?.setNavigationBarHidden(false, animated: animated)
    super.viewWillDisappear(animated)
  }

  private func nextPage(_ type: PageType) {
    contentView.updateProps(.beginLoading)
    model.getPage(type: type) { [unowned self] result in
      switch result {
      case let .success(page):
        updateView(page: page, type: type)
      case let .failure(error):
        print(error.description)
      }
    }
  }

  func updateView(page: PageDTO, type: PageType) {
    contentView.updateProps(.loaded(.init(
      characters: page.character,
      onLoad: page.info.next == nil ? nil : { [unowned self] type in
        contentView.updateProps(.beginLoading)
        nextPage(type)
      },
      onSelectCell: { [unowned self] character in
        navigationController?.pushViewController(
          DetailViewController(character: character),
          animated: true
        )
      }
    ), type))
  }

}
