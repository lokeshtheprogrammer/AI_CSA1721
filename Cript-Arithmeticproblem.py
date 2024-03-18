def is_valid_assignment(assignment, equation):
  """Checks if the current assignment of digits to letters is valid."""
  seen = set()
  for char, digit in assignment.items():
    if digit == 0 or digit in seen:
      return False
    seen.add(digit)
  return True

def solve_cryptarithmetic(equation):
  """Solves the cryptarithmetic problem using backtracking."""
  letters = set(equation.replace(" ", "")) - {"="}
  assignment = {}

  def backtrack(current_letter):
    if current_letter == None:
      # Check if all letters are assigned and equation holds
      left_side = 0
      right_side = 0
      multiplier = 1
      for char in reversed(equation.split("=")[0]):
        left_side += assignment[char] * multiplier
        multiplier *= 10
      multiplier = 1
      for char in reversed(equation.split("=")[1]):
        right_side += assignment[char] * multiplier
        multiplier *= 10
      if left_side == right_side:
        print(f"Solution Found: {assignment}")
      return

    for digit in range(1, 10):
      if digit not in assignment.values():
        assignment[current_letter] = digit
        if is_valid_assignment(assignment, equation):
          backtrack(letters.difference(assignment.keys()).pop())
        del assignment[current_letter]

  backtrack(letters.pop())

# Example usage
equation = "SEND + MORE = MONEY"
solve_cryptarithmetic(equation)

