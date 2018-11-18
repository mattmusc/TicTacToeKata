struct Field {
  var mark: String { didSet { isMarked = true } }
  var isMarked = false
  
  init(mark m: String) {
    self.mark = m
    self.isMarked = true
  }
  
  init(mark m: String, marked isM: Bool) {
    self.mark = m
    self.isMarked = isM
  }
}

struct GameGrid: CustomStringConvertible {
  let width: Int
  let height: Int
  let emptyMark: String

  var grid: [Field]

  init(width w: Int, height h: Int, emptyMark e: String) {
    self.width = w
    self.height = h
    self.emptyMark = e
    self.grid = Array(repeating: Field(mark: e, marked: false), count: w * h)
  }

  init(width w: Int, height h: Int, emptyMark e: String, grid g: [Field]) {
    self.width = w
    self.height = h
    self.grid = g
    self.emptyMark = e
  }

  var description: String {
    var s = ""
    for row in 0..<height {
      for column in 0..<width {
        s += " \(at(row: row, col: column)) "
      }
      s += "\n"
    }
    return s
  }
}

enum GameGridError: Error {
  case fieldAlreadyTaken
}

typealias RowCol = (row: Int, col: Int)

extension GameGrid {

  func isFull() -> Bool {
    return self.grid.filter { !$0.isMarked }.count == 0
  }

  func isRowFilled(mark m: String) -> Bool {
    return GridCheckingStrategy.Rows.check(grid: self, mark: m)
  }

  func isColumnFilled(mark m: String) -> Bool {
    return GridCheckingStrategy.Columns.check(grid: self, mark: m)
  }

  func isDiagonalFilled(mark m: String) -> Bool {
    return GridCheckingStrategy.Diagonal.check(grid: self, mark: m)
  }

  func count() -> Int {
    return self.grid.count
  }

  func at(row r: Int, col c: Int) -> String {
    return self.grid[r * width + c].mark
  }

  mutating func takeField(at i: Int, mark m: String) throws {
    guard self.grid[i].mark == self.emptyMark else {
      throw GameGridError.fieldAlreadyTaken
    }
    self.grid[i].mark = m
  }

  mutating func takeField(row r: Int, col c: Int, mark m: String) throws {
    guard at(row: r, col: c) == self.emptyMark else {
      throw GameGridError.fieldAlreadyTaken
    }
    self.grid[r * width + c].mark = m
    
  }
  
  mutating func reset() {
    grid = Array(repeating: Field(mark: emptyMark, marked: false), count: grid.count)
  }

}

extension GameConfig {

  func createGameGrid() -> GameGrid {
    return GameGrid(width: self.width, height: self.height, emptyMark: self.emptyMark)
  }

}
