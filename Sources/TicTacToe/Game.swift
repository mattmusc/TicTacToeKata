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
