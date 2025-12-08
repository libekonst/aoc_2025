import day_1/dial_direction.{type Direction, new_direction, turn_dial}
import gleam/int
import gleam/io
import gleam/result
import gleam/string
import simplifile

const initial_dial_position = 50

/// Answer is 1059
pub fn solve() {
  let input_path = "src/day_1/input.txt"

  let result =
    simplifile.read(input_path)
    |> result.map(fn(input) { echo string.split(input, on: "\n") })
    |> result.map(fn(sequence) {
      calculate_password(
        with: sequence,
        start: initial_dial_position,
        counter: 0,
      )
    })
    |> result.map(fn(password) {
      case password {
        Ok(count) ->
          io.println(
            "The number of times we hit zero is: " <> int.to_string(count),
          )
        // Error(simplifile.Enoent) -> io.println("Input file not found")
        Error(_) -> io.println("Error calculating password")
      }
    })
}

// const dial_size = 100

fn calculate_password(
  with sequence: List(String),
  start current_dial_position: Int,
  counter zero_points_counter: Int,
) -> Result(Int, Nil) {
  case sequence {
    [next_rotation, ..rest] ->
      new_direction(next_rotation)
      |> result.map(fn(direction) {
        turn_dial(towards: direction, from: current_dial_position)
      })
      |> result.flatten
      |> result.map(fn(new_position) {
        case new_position {
          0 ->
            calculate_password(
              with: rest,
              start: new_position,
              counter: zero_points_counter + 1,
            )
          _ ->
            calculate_password(
              with: rest,
              start: new_position,
              counter: zero_points_counter,
            )
        }
      })
      |> result.flatten

    [] -> Ok(zero_points_counter)
  }
  // current_dial_position
}
// sequence
// |> List.map(fn(line) {
//   line
//   |> string.split(on: " ")
//   |> List.map(fn(word) { string.to_int(word) })
//   |> List.sum()
// })
// |> List.sum()

// "L" <> turn_amount ->
//   turn_dial(at: Left(turn_amount), from: current_dial_position)

// fn turn_dial(
//   at direction: Direction,
//   from current_position: Int,
// ) -> Result(Int, Nil) {
//   case direction {
//     TurnLeft ->
//       amount
//       |> result.map(fn(amount) {
//         int.modulo(current_position - amount, dial_size)
//       })

//     TurnRight(turn_amount) ->
//       turn_amount
//       |> int.parse
//       |> result.map(fn(amount) {
//         int.modulo(current_position + amount, dial_size)
//       })
//   }
// |> result.flatten
// int.parse(turn_amount)
// |> result.map(fn(turn_amount) {
//   let new_dial_position = case direction {
//     Left(turn_amount) -> int.modulo(current_position - turn_amount, dial_size)
//     Right -> int.modulo(current_position + turn_amount, dial_size)
//   }
//   new_dial_position
// })
// |> result.flatten
// }
