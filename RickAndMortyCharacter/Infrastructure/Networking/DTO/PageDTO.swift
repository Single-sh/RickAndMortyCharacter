import Foundation

struct PageDTO: Codable {
  struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
  }

  let info: Info
  let character: [CharacterDTO]

  enum CodingKeys: String, CodingKey {
    case info = "info"
    case character = "results"
  }

}
