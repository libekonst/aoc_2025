import day_1/rotate_instruction as instruction
import gleam/int
import gleam/io
import gleam/result
import gleam/string

const initial_dial_position = 50

/// Answer is 1059
pub fn solve(input: String) -> Result(Int, Nil) {
  input
  |> string.split(on: "\n")
  |> calculate_password(start: initial_dial_position, counter: 0)
}

pub fn run(input: String) {
  case solve(input) {
    Ok(count) -> io.println("Day 1 solution: " <> int.to_string(count))
    Error(_) -> io.println("Error solving Day 1 puzzle 😵")
  }
}

/// Recursively process the list of instructions to calculate the final password.
/// When the dial reaches position 0, increment the crossings counter.
fn calculate_password(
  with sequence: List(String),
  start current_dial_position: Int,
  counter crossings_counter: Int,
) -> Result(Int, Nil) {
  case sequence {
    [] -> Ok(crossings_counter)

    [next_step, ..rest] -> {
      use direction <- result.try(instruction.new(next_step))
      use next_position <- result.try(instruction.turn_dial(
        towards: direction,
        from: current_dial_position,
      ))
      case next_position {
        0 ->
          calculate_password(
            with: rest,
            start: next_position,
            counter: crossings_counter + 1,
          )
        _ ->
          calculate_password(
            with: rest,
            start: next_position,
            counter: crossings_counter,
          )
      }
    }
  }
}
