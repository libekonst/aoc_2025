import day_1/day_1
import gleeunit/should

pub fn day_1_solve_with_sample_input_test() {
  let sample_input = "L50\nR50\nL100\nR100"

  // This input should result in:
  // Start: 50
  // After L50: 0 (counter: 1)
  // After R50: 50
  // After L100: 50 (wraps around)
  // After R100: 50 (wraps around)
  // So we expect 1 zero crossing

  day_1.solve(sample_input)
  |> should.equal(Ok(1))
}

pub fn day_1_solve_with_empty_input_test() {
  let empty_input = ""

  // Empty string splits to [""], which is an invalid instruction
  day_1.solve(empty_input)
  |> should.equal(Error(Nil))
}

pub fn day_1_solve_with_single_instruction_test() {
  let single_instruction = "L50"

  // Start at 50, turn left 50 -> position 0 (1 zero crossing)
  day_1.solve(single_instruction)
  |> should.equal(Ok(1))
}

pub fn day_1_solve_with_multiple_zero_crossings_test() {
  let input = "L50\nR100\nL100"

  // Start: 50
  // After L50: 0 (counter: 1)
  // After R100: 0 (counter: 2)
  // After L100: 0 (counter: 3)
  day_1.solve(input)
  |> should.equal(Ok(3))
}

pub fn day_1_solve_with_invalid_instruction_test() {
  let invalid_input = "L50\nINVALID\nR25"

  // Invalid instruction should cause an error
  day_1.solve(invalid_input)
  |> should.equal(Error(Nil))
}

pub fn day_1_solve_with_custom_sequence_test() {
  let input = "L68\nL30\nR48\nL5\nR60\nL55\nL1\nL99\nR14\nL82"

  // Start: 50
  // After L68: 82
  // After L30: 52
  // After R48: 0 (counter: 1)
  // After L5: 95
  // After R60: 55
  // After L55: 0 (counter: 2)
  // After L1: 99
  // After L99: 0 (counter: 3)
  // After R14: 14
  // After L82: 32
  day_1.solve(input)
  |> should.equal(Ok(3))
}
