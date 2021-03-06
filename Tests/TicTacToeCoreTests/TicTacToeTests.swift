import Quick
import Nimble

@testable import TicTacToeCore

final class TicTacToeTests: QuickSpec {

  override func spec() {

    describe("a game") {

      it("has 9 fields") {
        let game = Game(grid: GameGrid(width: 3, height: 3, emptyMark: " "))
        expect(game.fields.grid.count).to(equal(9))
      }

      it("has a width X height of 3x3") {
        let game = Game(grid: GameGrid(width: 3, height: 3, emptyMark: " "))
        expect(game.fields.width).to(equal(3))
        expect(game.fields.height).to(equal(3))
      }

      it("there are two players in the game (X and O)") {
        let game = Game(grid: GameGrid(width: 3, height: 3, emptyMark: " "), players: [Player(mark: "X"), Player(mark: "O")])

        expect(game.players.count).to(equal(2))
        expect(game.players[0].mark).to(equal("X"))
        expect(game.players[1].mark).to(equal("O"))
      }

      it("is over when all fields are taken") {
        var game = Game(grid: GameGrid(width: 3, height: 3, emptyMark: " ", grid: [
          Field(mark: "X"), Field(mark: "O"), Field(mark: "O"),
          Field(mark: "O"), Field(mark: "X"), Field(mark: "O"),
          Field(mark: "X"), Field(mark: "O"), Field(mark: "X")]))

        game.update()
        expect(game.isOver()).to(equal(true))
      }

      it("is over when all fields in a row are taken by a player - first row") {
        let config = KataConfig()

        let emptyGrid = config.createGameGrid()
        let players = config.createPlayers()

        var game = Game(grid: emptyGrid, players: players)

        do {
          try game.fields.takeField(at: 0, mark: "X")
          try game.fields.takeField(at: 1, mark: "X")
          try game.fields.takeField(at: 2, mark: "X")

        } catch {}

        game.update()
        expect(game.isOver()).to(equal(true))
      }

      it("is over when all fields in a row are taken by a player - second row") {
        let config = KataConfig()

        let emptyGrid = config.createGameGrid()
        let players = config.createPlayers()

        var game = Game(grid: emptyGrid, players: players)

        do {
          try game.fields.takeField(at: 3, mark: "X")
          try game.fields.takeField(at: 4, mark: "X")
          try game.fields.takeField(at: 5, mark: "X")

        } catch {}

        game.update()
        expect(game.isOver()).to(equal(true))
      }

      it("is over when all fields in a row are taken by a player - third row") {
        let config = KataConfig()

        let emptyGrid = config.createGameGrid()
        let players = config.createPlayers()

        var game = Game(grid: emptyGrid, players: players)

        do {
          try game.fields.takeField(at: 6, mark: "X")
          try game.fields.takeField(at: 7, mark: "X")
          try game.fields.takeField(at: 8, mark: "X")

        } catch {}

        game.update()
        expect(game.isOver()).to(equal(true))
      }

      it("is over when all fields in a row are taken by a player - first column") {
        let config = KataConfig()

        let emptyGrid = config.createGameGrid()
        let players = config.createPlayers()

        var game = Game(grid: emptyGrid, players: players)

        do {
          try game.fields.takeField(at: 0, mark: "X")
          try game.fields.takeField(at: 3, mark: "X")
          try game.fields.takeField(at: 6, mark: "X")

        } catch {}

        game.update()
        expect(game.isOver()).to(equal(true))
      }

      it("is over when all fields in a row are taken by a player - 0,4,8 diagonal") {
        let config = KataConfig()

        let emptyGrid = config.createGameGrid()
        let players = config.createPlayers()

        var game = Game(grid: emptyGrid, players: players)

        do {
          try game.fields.takeField(at: 0, mark: "X")
          try game.fields.takeField(at: 4, mark: "X")
          try game.fields.takeField(at: 8, mark: "X")

        } catch {}

        game.update()
        expect(game.isOver()).to(equal(true))
      }
    }

    describe("players") {

      let player1 = Player(mark: "X")
      let player2 = Player(mark: "O")

      let gameGrid = GameGrid(width: 1, height: 1, emptyMark: " ")
      let game = Game(grid: gameGrid, players: [player1, player2])

      let gameManager = GameManager(game: game)
      gameManager.ui = TestUI()

      context("in a game with \(game.players.count) players, \(player1.mark) and \(player2.mark), and a grid \(gameGrid.width)x\(gameGrid.height)") {

        it("players take turns taking fields until the game is over") {

          expect(gameManager.currentPlayer.mark).to(equal(player1.mark))
          gameManager.updateGame(command: .MarkField(row: 0, column: 0))
          expect(gameManager.game.fields.at(row: 0, col: 0)).to(equal(player1.mark))

          expect(gameManager.currentPlayer.mark).to(equal(player2.mark))

          expect(gameManager.game.isOver()).to(equal(true))
        }

      }

    }

    describe("a player") {

      it("can take a field if not already taken") {
        let config = KataConfig()
        var emptyGrid = config.createGameGrid()

        do {
          try emptyGrid.takeField(at: 0, mark: "X")
        } catch {}

        expect(emptyGrid.grid[0].mark).to(equal("X"))
      }

    }

    describe("a grid") {

      it("can be accessed with the method at(row, col)") {

        var grid = GameGrid(width: 3, height: 3, emptyMark: "_")

        do {
          try grid.takeField(at: 0, mark: "X")
          try grid.takeField(at: 1, mark: "X")
          try grid.takeField(at: 2, mark: "O")
        } catch {}

        expect(grid.at(row: 0, col: 0)).to(equal("X"))
        expect(grid.at(row: 0, col: 1)).to(equal("X"))
        expect(grid.at(row: 0, col: 2)).to(equal("O"))

      }

      it("has a row taken by a player when all cells in a row have the same symbol") {
        var grid = GameGrid(width: 3, height: 3, emptyMark: "_")

        do {
          try grid.takeField(at: 0, mark: "X")
          try grid.takeField(at: 1, mark: "X")
          try grid.takeField(at: 2, mark: "X")
        } catch {}

        expect(grid.isRowFilled(mark: "X")).to(equal(true))
      }

      it("has a column taken by a player when all cells in a column have the same symbol") {
        var grid = GameGrid(width: 3, height: 3, emptyMark: "_")

        do {
          try grid.takeField(at: 0, mark: "X")
          try grid.takeField(at: 3, mark: "X")
          try grid.takeField(at: 6, mark: "X")
        } catch {}

        expect(grid.isColumnFilled(mark: "X")).to(equal(true))
      }

      it("has no rows taken by a player if there no cells in a row with the same symbol") {
        var grid = GameGrid(width: 3, height: 3, emptyMark: "_")

        do {
          try grid.takeField(at: 0, mark: "O")
          try grid.takeField(at: 1, mark: "O")
          try grid.takeField(at: 2, mark: "X")
        } catch {}

        expect(grid.isRowFilled(mark: "O")).to(equal(false))
      }

      it("has the diagonal 0,0 - 1,1 - 2,2 taken by player") {
        var grid = GameGrid(width: 3, height: 3, emptyMark: "_")

        do {
          try grid.takeField(at: 0, mark: "X")
          try grid.takeField(at: 1, mark: "O")
          try grid.takeField(at: 2, mark: "O")

          try grid.takeField(at: 3, mark: "O")
          try grid.takeField(at: 4, mark: "X")
          try grid.takeField(at: 5, mark: "O")

          try grid.takeField(at: 6, mark: "O")
          try grid.takeField(at: 7, mark: "O")
          try grid.takeField(at: 8, mark: "X")
        } catch {}

        expect(grid.isDiagonalFilled(mark: "X")).to(equal(true))
      }

      it("has the diagonal 0,1 - 1,1 - 2,0 taken by player") {
        var grid = GameGrid(width: 3, height: 3, emptyMark: "_")

        do {
          try grid.takeField(at: 0, mark: "O")
          try grid.takeField(at: 1, mark: "O")
          try grid.takeField(at: 2, mark: "X")

          try grid.takeField(at: 3, mark: "O")
          try grid.takeField(at: 4, mark: "X")
          try grid.takeField(at: 5, mark: "O")

          try grid.takeField(at: 6, mark: "X")
          try grid.takeField(at: 7, mark: "O")
          try grid.takeField(at: 8, mark: "O")
        } catch {}

        expect(grid.isDiagonalFilled(mark: "X")).to(equal(true))
      }

      it("has all the grid full") {
        var grid = GameGrid(width: 3, height: 3, emptyMark: "_")

        do {
          try grid.takeField(at: 0, mark: "O")
          try grid.takeField(at: 1, mark: "O")
          try grid.takeField(at: 2, mark: "X")

          try grid.takeField(at: 3, mark: "O")
          try grid.takeField(at: 4, mark: "X")
          try grid.takeField(at: 5, mark: "O")

          try grid.takeField(at: 6, mark: "X")
          try grid.takeField(at: 7, mark: "O")
          try grid.takeField(at: 8, mark: "O")
        } catch {}

        expect(grid.isFull()).to(equal(true))
      }

      it("has a method description which returns a string with the description of the board") {
        var grid = GameGrid(width: 1, height: 1, emptyMark: "_")

        do {
          try grid.takeField(at: 0, mark: "O")
        } catch {}

        expect(String(describing: grid)).to(equal(" O \n"))
      }
    }

    describe("KataConfig") {

      it("has width and height equal to 3 and has emptyMark equal to '_'") {
        let kataConfig = KataConfig()

        expect(kataConfig.width).to(equal(3))
        expect(kataConfig.height).to(equal(3))
        expect(kataConfig.emptyMark).to(equal("_"))
      }

      it("has 2 players marks, X and O") {
        let kataConfig = KataConfig()

        expect(kataConfig.nOfPlayers).to(equal(2))
        expect(kataConfig.marks[0]).to(equal("X"))
        expect(kataConfig.marks[1]).to(equal("O"))
      }

    }

    describe("CommandParser") {

      let parser = CommandParser()

      it("'q' command is Quit command") {
        let parsed = parser.parse("q")
        expect(parsed).to(equal(.Quit))
      }

      it("1 1 is a valid command") {
        let parsed = parser.parse("1 1")
        expect(parsed).to(equal(Command.MarkField(row: 1, column: 1)))
      }

      it("a 1 is an Invalid command") {
        let parsed = parser.parse("a 1")
        expect(parsed).to(equal(Command.Invalid))
      }

      it("1 a is an Invalid command") {
        let parsed = parser.parse("1 a")
        expect(parsed).to(equal(Command.Invalid))
      }

      it("a a is an Invalid command") {
        let parsed = parser.parse("a a")
        expect(parsed).to(equal(Command.Invalid))
      }

      it("1a is an Invalid command") {
        let parsed = parser.parse("1a")
        expect(parsed).to(equal(Command.Invalid))
      }

      it("' ' is a Quit command") {
        let parsed = parser.parse(" ")
        expect(parsed).to(equal(Command.Quit))
      }
    }

  }

}
