import day_1/day_1
import gleam/io
import simplifile

pub fn main() -> Nil {
  io.println("🎄✨ Advent of code 2025 🎄✨")

  let input_file = "src/day_1/input.txt" |> simplifile.read

  case input_file {
    Ok(input) -> day_1.run(input)
    Error(simplifile.Enoent) -> io.println("Input file not found")
    Error(_) -> io.println("Error solving the puzzle 😵")
  }
}
