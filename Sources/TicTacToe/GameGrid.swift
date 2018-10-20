struct GameGrid {
  let width: Int
  let height: Int
  let emptyMark: String

  var grid: [String]

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
}

enum GameGridError: Error {
  case fieldAlreadyTaken
}

extension GameGrid {

  func isFull() -> Bool {
    return self.grid.filter { $0 == self.emptyMark }.count == 0
  }

  func count() -> Int {
    return grid.count
  }

  mutating func takeField(index i: Int, mark m: String) throws {
    guard self.grid[i] != self.emptyMark else {
      throw GameGridError.fieldAlreadyTaken
    }
    self.grid[i] = m
  }

}

extension GameConfig {

  func createGameGrid() -> GameGrid {
    return GameGrid(width: self.width, height: self.height, emptyMark: self.emptyMark)
  }

}
