import Quick
import Nimble

@testable import TicTacToe

final class TicTacToeTests: QuickSpec {

  override func spec() {

    describe("a game") {

      it("has 9 fields") {
        let game = Game(width: 3, height: 3)
        expect(game.grid.count).to(equal(9))
      }

      it("has a width X height of 3x3") {
        let game = Game(width: 3, height: 3)
        expect(game.width).to(equal(3))
        expect(game.height).to(equal(3))
      }

      it("is over when all fields are taken") {
        let game = Game(width: 3, height: 3, grid: [
          "X", "O", "O",
          "O", "X", "O",
          "X", "O", "X"])

        expect(game.isOver()).to(equal(true))
      }
    }

  }

}
