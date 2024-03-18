import heapq

# Define the size of the puzzle
N = 3

# Define the goal state
goal_state = [1, 2, 3, 4, 5, 6, 7, 8, 0]


def find_blank(state):
  """Finds the position of the blank tile in the state."""
  for i in range(N * N):
    if state[i] == 0:
      return i


def is_valid_move(state, blank_pos, move):
  """Checks if a move is valid for the given state."""
  rows = [1, 0, -1, 0]
  cols = [0, -1, 0, 1]
  new_pos = blank_pos + rows[move] + cols[move]
  return 0 <= new_pos < N * N


def generate_new_states(state):
  """Generates new states by moving the blank tile in all valid directions."""
  blank_pos = find_blank(state)
  new_states = []
  for move in range(4):
    if is_valid_move(state, blank_pos, move):
      new_state = list(state)
      new_state[blank_pos], new_state[blank_pos + rows[move] + cols[move]] = (
          new_state[blank_pos + rows[move] + cols[move]],
          new_state[blank_pos],
      )
      new_states.append(new_state)
  return new_states


def manhattan_distance(state):
  """Calculates the Manhattan distance heuristic for a state."""
  distance = 0
  for i in range(N * N):
    tile_value = state[i]
    goal_pos = (tile_value - 1) // N, (tile_value - 1) % N
    current_pos = i // N, i % N
    distance += abs(current_pos[0] - goal_pos[0]) + abs(current_pos[1] - goal_pos[1])
  return distance


class Node:
  """Represents a node in the search tree."""

  def __init__(self, state, parent=None, g_score=0):
    self.state = state
    self.parent = parent
    self.g_score = g_score  # Cost from the start state
    self.h_score = manhattan_distance(state)  # Heuristic score
    self.f_score = self.g_score + self.h_score  # Total score

  def __lt__(self, other):
    return self.f_score < other.f_score


def a_star_search(start_state):
  """Solves the 8-puzzle problem using A* search."""
  frontier = []
  explored = set()
  start_node = Node(start_state)
  heapq.heappush(frontier, start_node)

  while frontier:
    current_node = heapq.heappop(frontier)
    explored.add(tuple(current_node.state))

    if current_node.state == goal_state:
      # Solution found, reconstruct the path
      path = []
      while current_node:
        path.append(current_node.state)
        current_node = current_node.parent
      return path[::-1]  # Reverse the path

    for new_state in generate_new_states(current_node.state):
      if tuple(new_state) not in explored:
        new_node = Node(new_state, current_node, current_node.g_score + 1)
        heapq.heappush(frontier, new_node)

  return None  # No solution found


# Example usage
initial_state = [2, 8, 3, 1, 6, 4, 7, 0, 5]
solution = a_star_search(initial_state)

if solution:
  print("Solution found!")
  for state in solution:
    print(f"\n{' '.join(str(x) for x in state[:3])}")
    print(f"{' '.join(str(x) for x in state[3:6])}")
    print(f"{' '.join(str(x) for x

