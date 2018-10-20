import Quick
import Nimble

@testable import TicTacToe

final class TicTacToeTests: QuickSpec {

  override func spec() {

    describe("a game") {

      it("has 9 fields") {
        let game = Game(grid: GameGrid(width: 3, height: 3))
        expect(game.fields.grid.count).to(equal(9))
      }

      it("has a width X height of 3x3") {
        let game = Game(grid: GameGrid(width: 3, height: 3))
        expect(game.fields.width).to(equal(3))
        expect(game.fields.height).to(equal(3))
      }

      it("is over when all fields are taken") {
        let game = Game(grid: GameGrid(width: 3, height: 3, grid: [
          "X", "O", "O",
          "O", "X", "O",
          "X", "O", "X"]))

        expect(game.isOver()).to(equal(true))
      }

      it("there are two players in the game (X and O)") {
        let game = Game(players: [Player(mark: "X"), Player(mark: "O")])

        expect(game.players.count).to(equal(2))
      }

    }

  }

}
