import Mustard

public class TicTacToeApp {
  let gameManager: GameManager

  public init() {
    self.gameManager = GameManager(config: KataConfig())
  }

  public func start() {
    self.gameManager.loop()
  }
}

