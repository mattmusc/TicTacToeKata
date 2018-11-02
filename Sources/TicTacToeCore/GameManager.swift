public class GameManager {
  var game: Game
  
  var currentPlayer: Player
  var currentPlayerIndex = 0
  
  var quitRequested = false
  var printStatements = true
  
  private (set) var mark2player: [String: Player]
  
  init(config cfg: GameConfig) {
    let grid = cfg.createGameGrid()
    let players = cfg.createPlayers()
    
    self.game = Game(grid: grid, players: players)
    self.currentPlayer = players[currentPlayerIndex]
    
    self.mark2player = [String: Player]()
    for player in self.game.players {
      self.mark2player[player.mark] = player
    }
  }
  
  init(game g: Game) {
    self.game = g
    self.currentPlayer = g.players[currentPlayerIndex]

    self.mark2player = [String: Player]()
    for player in self.game.players {
      self.mark2player[player.mark] = player
    }
  }

  public func loop() {
    welcome(currentPlayer.mark)
    
    repeat {
      if let line = readLine() {
        let parsed = CommandParser().parse(line)
        
        self.update(command: parsed)
      }
    } while !game.isOver() && !quitRequested
    
    if printStatements {
      print("Goodbye")
    }
  }
  
  public func update(command cmd: Command) {
    switch cmd {
    case .Invalid:
      if printStatements {
        print("> Invalid command.")
      }
      
    case .Quit:
      quitRequested = true
      
    case .MarkField(let val):
      do {
        try self.game.fields.takeField(row: val.row, col: val.column, mark: currentPlayer.mark)
      } catch {}
      
      switchPlayer(currentPlayerIndex)
    }
    
    self.game.update()
    afterCommand(currentPlayer.mark)
  }
  
  func afterCommand(_ mark: String) {
    switch game.state {
    case .Playing:
      if !quitRequested {
        if printStatements {
          print(String(describing: self.game.fields))
          print("Now it's \(mark) turn.")
        }
      }
    case .Draw:
      if printStatements {
        print("It's draw.")
      }
    case .PlayerWon:
      if printStatements {
        print("Congratulations \(self.game.winner?.mark ?? ""), you won!")
      }
    }
  }
  
  func switchPlayer(_ index: Int) {
    currentPlayerIndex = (index == 0) ? 1 : 0
    currentPlayer = self.game.players[currentPlayerIndex]
  }
  
  func welcome(_ mark: String) {
    if printStatements {
      print("Hi!, Welcome to TicTacToe. You are \(mark). You have a \(game.fields.width)x\(game.fields.height) grid.")
    }
  }
}
