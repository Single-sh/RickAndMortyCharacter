import Foundation
import Moya

enum PageType {
  case refresh
  case next
}
protocol CharactersModelDelegate {
  func getPage(type: PageType, completion: @escaping (Result<PageDTO, DescriptionError>) -> ())
}

class CharactersModel: CharactersModelDelegate {
  private let provider: MoyaProvider<RickAndMortyService>
  private var page = 0

  init() {
    provider = MoyaProvider<RickAndMortyService>()
  }

  func getPage(type: PageType, completion: @escaping (Result<PageDTO, DescriptionError>) -> ()) {
    switch type {
    case .next:
      page += 1
    default:
      page = 1
    }
    provider.request(.getPage(page: page)) { result in
      switch result {
      case let .success(response):
        do {
          let page = try response.map(PageDTO.self)
          completion(.success(page))
        }
        catch {
          completion(.failure(.init(description: "Error parse PageDTO")))
        }
      case let .failure(error):
        completion(.failure(.init(description: error.localizedDescription)))
      }
    }
  }
}

struct DescriptionError: Error {
  let description: String
}
