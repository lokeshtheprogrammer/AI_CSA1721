person(name(Name), dob(Year, Month, Day)) :-
  % Add your data here in the format: person(name('Name'), dob(Year, Month, Day)).
  person(name('Alice'), dob(1990, 1, 1)).
  person(name('Bob'), dob(1985, 12, 31)).

% Example query to find all people born in a specific month
find_birthdays(Month, People) :-
  findall(Person, (person(Person, dob(_, Month, _)), Person), People).

