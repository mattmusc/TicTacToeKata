public class GameConfig {
  let width: Int
  let height: Int
  let nOfPlayers: Int
  let marks: [String]
  let emptyMark: String

  public init(width w: Int, height h: Int, players p: [String], empty e: String) {
    self.width = w
    self.height = h
    self.nOfPlayers = p.count
    self.marks = p
    self.emptyMark = e
  }
  
  public func getEmptyMark() -> String {
    return emptyMark
  }
}

public class KataConfig: GameConfig {
  public init() {
    super.init(width: 3, height: 3, players: ["X", "O"], empty: "_")
  }
}
