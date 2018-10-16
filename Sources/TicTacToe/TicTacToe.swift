struct Game {
    let width: Int
    let height: Int

    let grid: [String]

    init(width w: Int, height h: Int) {
      self.width = w
      self.height = h
      self.grid = Array(repeating: " ", count: w * h)
    }

    init(width w: Int, height h: Int, grid g: [String]) {
      self.width = w
      self.height = h
      self.grid = g
    }

    func isOver() -> Bool {
      return self.grid.filter { $0 == " " }.count == 0
    }
}
