public enum Command: Equatable {
  case Quit
  case MarkField(row: Int, column: Int)
  case Invalid
}

class CommandParser {
  func parse(_ line: String) -> Command {
    let commands = line.components(matchedWith: .letters, .decimalDigits, .decimalDigits)

    if commands.count < 1 {
      return .Quit
    }

    if "q" == commands[0] {
      return .Quit
    }

    if commands.count > 1 {
      let row = Int(commands[0])
      let column = Int(commands[1])

      guard row ?? -1 >= 0 else {
        return .Invalid
      }

      guard column ?? -1 >= 0 else {
        return .Invalid
      }

      return .MarkField(row: row ?? -1, column: column ?? -1)
    }

    return .Invalid
  }
}

