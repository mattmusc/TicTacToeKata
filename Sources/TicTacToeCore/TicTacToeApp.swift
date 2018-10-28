import Mustard

public class TicTacToeApp {

  public init() {}

  public func start() {
    if let line = readLine() {
      let commands = line.components(matchedWith: .letters, .decimalDigits, .letters)
      print(commands)
    }
  }
}

