planet(Name, Diameter, DistanceFromSun).

% Example data (replace with actual values)
planet('Mercury', 4879, 57.9).
planet('Venus', 12104, 108.2).
planet('Earth', 12742, 149.6).
planet('Mars', 6779, 227.9).

% Example query to find the farthest planet from the Sun
farthest_planet(Planet) :-
  findall(Planet, (planet(Planet, _, Distance)), Planets),
  max_list(Planets, Distance, _),
  planet(Planet, _, Distance).

