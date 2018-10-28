struct Game {
  var fields: GameGrid
  var players: [Player]

  init(grid g: GameGrid) {
    self.fields = g
    self.players = [Player]()
  }

  init(grid g: GameGrid, players ps: [Player]) {
    self.fields = g
    self.players = ps
  }

  func isOver() -> Bool {
    return self.fields.isFull() || self.hasWinner()
  }

  func hasWinner() -> Bool {
    for player in players {
      for strategy in GridCheckingStrategy.allCases {
        if (strategy.check(grid: self.fields, mark: player.mark)) {
          return true
        }
      }
    }

    return false
  }

}
