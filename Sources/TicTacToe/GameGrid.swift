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

  func isRowTakenByPlayer(mark m: String) -> Bool {
    var isTaken = true

    for row in 0..<height {
      
      isTaken = true
      for col in 0..<width {
        let gridMark = self.at(row: row, col: col)
        
        if (gridMark != m) {
          isTaken = false
          break
        }
      }
      
      if (isTaken) {
        break
      }
    }

    return isTaken
  }
  
  func isColumnTakenByPlayer(mark m: String) -> Bool {
    var isTaken = true
    
    for col in 0..<width {
      
      isTaken = true
      for row in 0..<height {
        let gridMark = self.at(row: row, col: col)
        
        if (gridMark != m) {
          isTaken = false
          break
        }
      }
      
      if (isTaken) {
        break
      }
    }
    
    return isTaken
  }
  
  func isDiagonalTakenByPlayer(mark m: String) -> Bool {
    let numOfRows: [Int] = Array(0..<height)
    return
      numOfRows.map { at(row: $0, col: $0 ) }.allSatisfy { $0 == m }
      ||
      numOfRows.map { at(row: $0, col: width - $0 - 1 ) }.allSatisfy { $0 == m }
  }

  func count() -> Int {
    return self.grid.count
  }

  func at(row r: Int, col c: Int) -> String {
    return self.grid[r * width + c]
  }

  mutating func takeField(at i: Int, mark m: String) throws {
    guard self.grid[i] == self.emptyMark else {
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
