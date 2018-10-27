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
    return self.fields.isFull() || self.isGameWonByAPlayer()
  }

  func isGameWonByAPlayer() -> Bool {
    for player in players {
      if (self.fields.isRowTakenByPlayer(mark: player.mark)) {
        return true
      }
      
      if (self.fields.isColumnTakenByPlayer(mark: player.mark)) {
        return true
      }
      
      if (self.fields.isDiagonalTakenByPlayer(mark: player.mark)) {
        return true
      }
    
    }
    
    return false
  }

}
