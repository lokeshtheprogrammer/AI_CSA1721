import numpy as np

def distance_matrix(cities):
  """
  Calculates the distance matrix between all pairs of cities.

  Args:
      cities: A list of city coordinates (e.g., [[x1, y1], [x2, y2], ...]).

  Returns:
      A numpy array representing the distance matrix.
  """
  n = len(cities)
  distances = np.zeros((n, n))
  for i in range(n):
    for j in range(i + 1, n):
      # Use Euclidean distance as an example
      dist = np.sqrt(np.sum((cities[i] - cities[j])**2))
      distances[i][j] = distances[j][i] = dist
  return distances

def nearest_neighbor(distances):
  """
  Solves the TSP using the nearest neighbor heuristic.

  Args:
      distances: A numpy array representing the distance matrix.

  Returns:
      A list representing the order of visiting cities (starting and ending at the first city).
  """
  n = len(distances)
  visited = set([0])  # Start from the first city
  path = [0]

  for _ in range(1, n):
    min_dist = np.inf
    min_index = None
    for i in range(n):
      if i not in visited and distances[path[-1]][i] < min_dist:
        min_dist = distances[path[-1]][i]
        min_index = i
    visited.add(min_index)
    path.append(min_index)

  return path + [0]  # Return to the starting city

# Example usage
cities = [[1, 2], [4, 5], [7, 8]]
distances = distance_matrix(cities)
tour = nearest_neighbor(distances.copy())  # Avoid modifying the original matrix

print("City order:", tour)
print("Total distance:", np.sum(distances[tour[:-1], tour[1:]]))

