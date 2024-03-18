fruit(apple, red).
fruit(banana, yellow).
fruit(orange, orange).

% Backtracking implementation
color_of(Fruit, Color) :-
  fruit(Fruit, Color).

color_of(Fruit, Color) :-
  fruit(_, AnotherColor),
  color_of(Fruit, AnotherColor),
  \+ color_of(Fruit, Color).  % Backtrack if a different color is found

% Example usage
query(color_of(apple, WhatColor)).

