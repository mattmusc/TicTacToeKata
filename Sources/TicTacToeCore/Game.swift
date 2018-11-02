public enum GameState {
  case Draw
  case PlayerWon
  case Playing
}

struct Game {
  var fields: GameGrid
  var players: [Player]
  
  var state: GameState
  var winner: Player?

  init(grid g: GameGrid) {
    self.fields = g
    self.players = [Player]()
    self.state = .Playing
  }

  init(grid g: GameGrid, players ps: [Player]) {
    self.fields = g
    self.players = ps
    self.state = .Playing
  }

  mutating func isOver() -> Bool {
    return state != .Playing
  }

  mutating func update() {
    /// Check if a player won
    for player in players {
      for strategy in GridCheckingStrategy.allCases {
        if (strategy.check(grid: self.fields, mark: player.mark)) {
          self.state = .PlayerWon
          self.winner = player
        }
      }
    }
    
    /// Check if Grid is full
    if (state != .PlayerWon && self.fields.isFull()) {
      self.state = .Draw
    }
  }

}
