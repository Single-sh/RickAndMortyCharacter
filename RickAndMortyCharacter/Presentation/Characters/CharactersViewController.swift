import UIKit
import Moya

class CharactersViewController: UIViewController {
  private let contentView = CharactersView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view = contentView

    let provider = MoyaProvider<RickAndMortyService>()
    provider.request(.getPage(page: 1)) { (result) in
      switch result {
      case let .success(response):
        do {
          let page = try JSONDecoder().decode(PageDTO.self, from: response.data)
          self.updateView(page: page)
        }
        catch {
          // show an error to your user
        }
      case let .failure(error):
        print(error.localizedDescription ?? "")
      }
    }
  }

  func updateView(page: PageDTO) {
    contentView.updateProps(.loaded(.init(
      pages: 0,
      characters: page.character,
      nextPages: .init(enabled: true, onTap: {}),
      previous: .init(enabled: true, onTap: {})
    )))
  }

}
