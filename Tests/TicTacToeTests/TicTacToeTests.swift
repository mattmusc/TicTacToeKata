import Quick
import Nimble

@testable import TicTacToe

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

      it("is over when all fields are taken") {
        let game = Game(grid: GameGrid(width: 3, height: 3, emptyMark: " ", grid: [
          "X", "O", "O",
          "O", "X", "O",
          "X", "O", "X"]))

        expect(game.isOver()).to(equal(true))
      }

      it("there are two players in the game (X and O)") {
        let game = Game(grid: GameGrid(width: 3, height: 3, emptyMark: " "), players: [Player(mark: "X"), Player(mark: "O")])

        expect(game.players.count).to(equal(2))
        expect(game.players[0].mark).to(equal("X"))
        expect(game.players[1].mark).to(equal("O"))
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

    describe("KataConfig") {

      it("has width and height equal to 3 and has emptyMark equal to ' '") {
        let kataConfig = KataConfig()

        expect(kataConfig.width).to(equal(3))
        expect(kataConfig.height).to(equal(3))
        expect(kataConfig.emptyMark).to(equal(" "))
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
