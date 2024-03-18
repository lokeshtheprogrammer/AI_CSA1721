def dfs(graph, start_vertex, visited=None):
  """Performs a DFS traversal on a graph starting from a vertex.

  Args:
      graph: A dictionary representing the graph. Keys are vertices, values are lists of adjacent vertices.
      start_vertex: The starting vertex for the traversal.
      visited: An optional set to keep track of visited vertices (defaults to None).

  Returns:
      A list containing the vertices visited in the DFS order.
  """
  if visited is None:
    visited = set()
  visited.add(start_vertex)
  print(start_vertex, end=" ")  # Visit the current vertex

  for neighbor in graph[start_vertex]:
    if neighbor not in visited:
      dfs(graph, neighbor, visited)  # Recursive call for neighbors

# Example usage
graph = {
  'A': ['B', 'C'],
  'B': ['D', 'E'],
  'C': ['F'],
  'D': [],
  'E': [],
  'F': []
}

dfs(graph, 'A')

