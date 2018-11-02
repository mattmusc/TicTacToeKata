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
          "X", "O", "O",
          "O", "X", "O",
          "X", "O", "X"]))
        
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

      let gameGrid = GameGrid(width: 3, height: 3, emptyMark: " ")

      let game = Game(grid: gameGrid, players: [player1, player2])

      context("in a game with two players, X and O, and a grid 3x3") {

        it("players take turns taking fields until the game is over") {


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

        expect(emptyGrid.grid[0]).to(equal("X"))
      }

    }

    describe("a grid") {

      it("can be accessed with the method at(row, col)") {

        var grid = GameGrid(width: 3, height: 3, emptyMark: " ")

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
        var grid = GameGrid(width: 3, height: 3, emptyMark: " ")

        do {
          try grid.takeField(at: 0, mark: "X")
          try grid.takeField(at: 1, mark: "X")
          try grid.takeField(at: 2, mark: "X")
        } catch {}

        expect(grid.isRowFilled(mark: "X")).to(equal(true))
      }

      it("has no rows taken by a player if there no cells in a row with the same symbol") {
        var grid = GameGrid(width: 3, height: 3, emptyMark: " ")

        do {
          try grid.takeField(at: 0, mark: "O")
          try grid.takeField(at: 1, mark: "O")
          try grid.takeField(at: 2, mark: "X")
        } catch {}

        expect(grid.isRowFilled(mark: "O")).to(equal(false))
      }

      it("has the diagonal 0,0 - 1,1 - 2,2 taken by player") {
        var grid = GameGrid(width: 3, height: 3, emptyMark: " ")

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
        var grid = GameGrid(width: 3, height: 3, emptyMark: " ")

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

  }

}
