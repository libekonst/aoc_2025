import gleam/int
import gleam/result
import gleam/string

pub opaque type RotateInstruction {
  TurnLeft(Int)
  TurnRight(Int)
}

pub fn new(direction: String) -> Result(RotateInstruction, Nil) {
  case string.trim(direction) {
    "L" <> amount_str -> int.parse(amount_str) |> result.map(TurnLeft)
    "R" <> amount_str -> int.parse(amount_str) |> result.map(TurnRight)
    _ -> Error(Nil)
  }
}

const dial_size = 100

pub fn turn_dial(
  towards direction: RotateInstruction,
  from current_position: Int,
) -> Result(Int, Nil) {
  case direction {
    TurnLeft(amount) -> int.modulo(current_position - amount, dial_size)
    TurnRight(amount) -> int.modulo(current_position + amount, dial_size)
  }
}
