import Foundation
import Moya

enum RickAndMortyService {
  case getPage(page: Int)
}

extension RickAndMortyService: TargetType {
  var baseURL: URL {
    return URL(string: "https://rickandmortyapi.com/api")!
  }

  var path: String {
    switch self {
    case .getPage:
      return "/character"
    }
  }

  var method: Moya.Method {
    switch self {
    case .getPage:
      return .get
    }
  }

  var sampleData: Data {
    switch self {
    case .getPage:
      return "Half measures are as bad as nothing at all.".utf8Encoded
    }
  }

  var task: Task {
    switch self {
    case let .getPage(page):
      return .requestParameters(parameters: ["page": page], encoding: URLEncoding.queryString)
    }
  }

  var headers: [String : String]? {
    return ["Content-type": "application/json"]
  }

}

private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }

    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
