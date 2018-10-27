enum GridCheckingStrategy {
  case Rows
  case Columns
  case Diagonal

  func check(grid g: GameGrid, mark m: String) -> Bool {
    switch self {
    case .Rows:
      let strategy = RowGCStrategy()
      return strategy.checkGrid(g, m)
    case .Columns:
      let strategy = ColumnGCStrategy()
      return strategy.checkGrid(g, m)
    case .Diagonal:
      let strategy = DiagonalGCStrategy()
      return strategy.checkGrid(g, m)
    }
  }
}

protocol GCStrategy {
  func checkGrid(_ grid: GameGrid, _ mark: String) -> Bool
}

class RowGCStrategy: GCStrategy {

  func checkGrid(_ grid: GameGrid, _ mark: String) -> Bool {
    var isTaken = true

    for row in 0..<grid.height {

      isTaken = true
      for col in 0..<grid.width {
        let gridMark = grid.at(row: row, col: col)

        if (gridMark != mark) {
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

}

class ColumnGCStrategy: GCStrategy {

  func checkGrid(_ grid: GameGrid, _ mark: String) -> Bool {
    var isTaken = true

    for row in 0..<grid.height {

      isTaken = true
      for col in 0..<grid.width {
        let gridMark = grid.at(row: col, col: row)

        if (gridMark != mark) {
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

}

class DiagonalGCStrategy: GCStrategy {

  func checkGrid(_ grid: GameGrid, _ mark: String) -> Bool {
    let numOfRows: [Int] = Array(0..<grid.height)
    return
      numOfRows.map { grid.at(row: $0, col: $0 ) }.allSatisfy { $0 == mark }
      ||
      numOfRows.map { grid.at(row: $0, col: grid.width - $0 - 1 ) }.allSatisfy { $0 == mark }
  }

}

