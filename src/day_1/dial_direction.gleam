import gleam/int
import gleam/result
import gleam/string

pub opaque type Direction {
  TurnLeft(Int)
  TurnRight(Int)
}

pub fn new_direction(direction: String) -> Result(Direction, Nil) {
  case string.trim(direction) {
    "L" <> amount_str ->
      int.parse(amount_str)
      |> result.map(fn(amount) { TurnLeft(amount) })

    "R" <> amount_str ->
      int.parse(amount_str)
      |> result.map(fn(amount) { TurnRight(amount) })

    _ -> Error(Nil)
  }
}

const dial_size = 100

pub fn turn_dial(
  towards direction: Direction,
  from current_position: Int,
) -> Result(Int, Nil) {
  case direction {
    TurnLeft(amount) -> int.modulo(current_position - amount, dial_size)

    TurnRight(amount) -> int.modulo(current_position + amount, dial_size)
  }
}
