struct Player {
  let mark: String

  init(mark m: String) {
    self.mark = m
  }
}

struct GameGrid {
  let width: Int
  let height: Int

  let grid: [String]

  init(width w: Int, height h: Int) {
    self.width = w
    self.height = h
    self.grid = Array(repeating: " ", count: w * h)
  }

  init(width w: Int, height h: Int, grid g: [String]) {
    self.width = w
    self.height = h
    self.grid = g
  }

  func isFull() -> Bool {
    return self.grid.filter { $0 == " " }.count == 0
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

  init(players ps: [Player]) {
    self.fields = GameGrid(width: 3, height: 3)
    self.players = ps
  }

  func isOver() -> Bool {
    return self.fields.isFull()
  }
}

