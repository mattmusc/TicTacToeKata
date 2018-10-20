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
    super.init(width: 3, height: 3, players: ["X", "O"], empty: " ")
  }
}

extension GameConfig {

  func createGameGrid() -> GameGrid {
    return GameGrid(width: self.width, height: self.height, emptyMark: self.emptyMark)
  }

  func createPlayers() -> [Player] {
    return self.marks.map { Player(mark: $0) }
  }

}

struct Player {
  let mark: String

  init(mark m: String) {
    self.mark = m
  }
}

struct GameGrid {
  let width: Int
  let height: Int
  let emptyMark: String

  let grid: [String]

  init(width w: Int, height h: Int, emptyMark e: String) {
    self.width = w
    self.height = h
    self.emptyMark = e
    self.grid = Array(repeating: e, count: w * h)
  }

  init(width w: Int, height h: Int, emptyMark e: String, grid g: [String]) {
    self.width = w
    self.height = h
    self.grid = g
    self.emptyMark = e
  }

  func isFull() -> Bool {
    return self.grid.filter { $0 == self.emptyMark }.count == 0
  }

  func count() -> Int {
    return grid.count
  }
}

struct Game {
  let fields: GameGrid
  let players: [Player]

  init(grid g: GameGrid) {
    self.fields = g
    self.players = [Player]()
  }

  init(grid g: GameGrid, players ps: [Player]) {
    self.fields = g
    self.players = ps
  }

  func isOver() -> Bool {
    return self.fields.isFull()
  }
}

struct GameManager {
  var game: Game
  var currentPlayer: Player?

  init(config cfg: GameConfig) {
    self.game = Game(grid: cfg.createGameGrid(), players: cfg.createPlayers())
    self.currentPlayer = nil
  }
}

