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

  static var `default`: PageDTO {
    PageDTO(info: .init(count: 0, pages: 0, next: nil, prev: nil), character: [])
  }

}
