struct GameManager {
  var game: Game
  var currentPlayer: Player?

  init(config cfg: GameConfig) {
    self.game = Game(grid: cfg.createGameGrid(), players: cfg.createPlayers())
    self.currentPlayer = nil
  }

}
