class GameConfig {
  let width: Int
  let height: Int
  let nOfPlayers: Int
  let marks: [String]
  let emptyMark: String

  init(width w: Int, height h: Int, players p: [String], empty e: String) {
    self.width = w
    self.height = h
    self.nOfPlayers = p.count
    self.marks = p
    self.emptyMark = e
  }
}

class KataConfig: GameConfig {
  init() {
    super.init(width: 3, height: 3, players: ["X", "O"], empty: "_")
  }
}
