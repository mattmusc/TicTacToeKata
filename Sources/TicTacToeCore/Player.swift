public struct Player {
  public let mark: String

  init(mark m: String) {
    self.mark = m
  }
}


extension GameConfig {

  func createPlayers() -> [Player] {
    return self.marks.map { Player(mark: $0) }
  }

}

