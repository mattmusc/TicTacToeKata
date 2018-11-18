public class GameManager {
  var game: Game
  var ui: GameUI
  
  public private(set) var config: GameConfig?

  var currentPlayer: Player
  var currentPlayerIndex = 0

  private (set) var mark2player: [String: Player]

  public init(config cfg: GameConfig) {
    self.config = cfg
    
    let grid = cfg.createGameGrid()
    let players = cfg.createPlayers()

    self.game = Game(grid: grid, players: players)
    self.currentPlayer = players[currentPlayerIndex]

    self.mark2player = [String: Player]()
    for player in self.game.players {
      self.mark2player[player.mark] = player
    }

    self.ui = ConsoleUI()
  }
  
  public init(config cfg: GameConfig, userInterface ui: GameUI) {
    self.config = cfg
    
    let grid = cfg.createGameGrid()
    let players = cfg.createPlayers()
    
    self.game = Game(grid: grid, players: players)
    self.currentPlayer = players[currentPlayerIndex]
    
    self.mark2player = [String: Player]()
    for player in self.game.players {
      self.mark2player[player.mark] = player
    }
    
    self.ui = ui
  }

  init(game g: Game) {
    self.game = g
    self.currentPlayer = g.players[currentPlayerIndex]

    self.mark2player = [String: Player]()
    for player in self.game.players {
      self.mark2player[player.mark] = player
    }

    self.ui = ConsoleUI()
  }
}

extension GameManager {
  
  public func loop() {
    repeat {
      switch game.state {
        
      case .Welcome:
        self.ui.update(gameManager: self)
        self.game.state = .Playing
        
      case .Playing:
        if let line = readLine(strippingNewline: true) {
          let parsed = CommandParser().parse(line)
          
          self.updateGame(command: parsed)
        }
        
        self.ui.update(gameManager: self)
        
      default:
        self.ui.update(gameManager: self)
      }
      
    } while !game.isOver()
  }
  
  public func updateGame(command cmd: Command) {
    switch cmd {
    case .Invalid:
      self.game.state = .InvalidCommand
      
    case .Quit:
      self.game.state = .Quit
      
    case .MarkField(let val):
      do {
        try self.game.fields.takeField(row: val.row, col: val.column, mark: currentPlayer.mark)
      } catch {}
      
      switchPlayer(currentPlayerIndex)
    }
    
    self.game.update()
  }
  
  public func resetGame() {
    self.game.state = .Welcome
    self.game.fields.reset()
  }
  
  public func getCurrentPlayer() -> Player {
    return currentPlayer
  }
  
  public func getWinner() -> Player? {
    return game.winner
  }
  
  func switchPlayer(_ index: Int) {
    currentPlayerIndex = (index == 0) ? 1 : 0
    currentPlayer = self.game.players[currentPlayerIndex]
  }
  
}
