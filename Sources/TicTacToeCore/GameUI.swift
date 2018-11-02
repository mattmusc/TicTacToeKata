protocol GameUI {
  func update(gameManager manager: GameManager)
}

class ConsoleUI: GameUI {
  func update(gameManager manager: GameManager) {
    let mark = manager.currentPlayer.mark
    let grid = manager.game.fields

    let gameState = manager.game.state
    switch gameState {

    case .Draw:
      print("It's a draw, bye")

    case .InvalidCommand:
      print("You entered and invalid command")

    case .PlayerWon:
      print("Congratulations \(manager.game.winner?.mark ?? ""), you won!")

    case .Playing:
      print(String(describing: grid))
      print("Now it's \(mark) turn.")

    case .Quit:
      print("You decided to end the game before it was over, Goodbye!")

    case .Welcome:
      print("Hi!, Welcome to TicTacToe. You are \(mark). You have a \(grid.width)x\(grid.height) grid.")

    }
  }
}

class TestUI: GameUI {
  func update(gameManager manager: GameManager) {}
}
