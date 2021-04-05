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
    nextPage()
  }

  override func viewWillAppear(_ animated: Bool) {
    navigationController?.setNavigationBarHidden(true, animated: animated)
    super.viewWillAppear(animated)
  }

  override func viewWillDisappear(_ animated: Bool) {
    navigationController?.setNavigationBarHidden(false, animated: animated)
    super.viewWillDisappear(animated)
  }

  private func nextPage() {
    contentView.updateProps(.beginLoading)
    model.nextPage { [unowned self] result in
      switch result {
      case let .success(page):
        updateView(page: page)
      case let .failure(error):
        print(error.description)
      }
    }
  }

  func updateView(page: PageDTO) {
    contentView.updateProps(.loaded(.init(
      characters: page.character,
      onLoad: page.info.next == nil ? nil : { [unowned self] in
        contentView.updateProps(.beginLoading)
        nextPage()
      },
      onSelectCell: { [unowned self] character in
        navigationController?.pushViewController(
          DetailViewController(character: character),
          animated: true
        )
      }
    )))
  }

}
