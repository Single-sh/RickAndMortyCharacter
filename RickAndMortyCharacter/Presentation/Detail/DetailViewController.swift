import Foundation
import UIKit

class DetailViewController: BaseViewController {
  private let character: CharacterDTO
  private let contentView = DetailView()

  init(character: CharacterDTO) {
    self.character = character
    super.init()
  }

  override func loadView() {
    view = contentView
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    contentView.updateProps(.init(
      name: character.name,
      status: character.status,
      gender: character.gender,
      species: character.species,
      imageUrl: character.image
    ))
  }

}
