import day_1/instruction
import gleam/int
import gleam/io
import gleam/string

const initial_dial_position = 50

/// Answer is 1059
pub fn solve(input: String) {
  let result =
    input
    |> string.split(on: "\n")
    |> calculate_password(start: initial_dial_position, counter: 0)

  case result {
    Ok(count) -> io.println("Day 1 solution: " <> int.to_string(count))
    Error(_) -> io.println("Error solving Day 1 puzzle 😵")
  }
}

fn calculate_password(
  with sequence: List(String),
  start current_dial_position: Int,
  counter zero_points_counter: Int,
) -> Result(Int, Nil) {
  case sequence {
    [] -> Ok(zero_points_counter)

    [next_step, ..rest] -> {
      case instruction.new(next_step) {
        Error(_) -> Error(Nil)
        Ok(direction) -> {
          case
            instruction.turn_dial(
              towards: direction,
              from: current_dial_position,
            )
          {
            Error(_) -> Error(Nil)
            Ok(next_position) ->
              case next_position {
                0 ->
                  calculate_password(
                    with: rest,
                    start: next_position,
                    counter: zero_points_counter + 1,
                  )
                _ ->
                  calculate_password(
                    with: rest,
                    start: next_position,
                    counter: zero_points_counter,
                  )
              }
          }
        }
      }
    }
  }
}
