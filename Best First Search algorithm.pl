% State representation (replace with your specific state structure)
state(at(home)).
state(at(work)).
state(at(bank)).

% Action definition (replace with your domain-specific actions)
action(go(home, work), state(at(work))).
action(go(work, home), state(at(home))).
action(go(work, bank), state(at(bank))).
action(go(bank, work), state(at(work))).

% Heuristic function (replace with your problem-specific heuristic)
heuristic(at(home), 0).
heuristic(at(work), 2).  # Distance from work to goal (adjust as needed)
heuristic(at(bank), 1).   # Distance from bank to goal (adjust as needed)

% Successor function (replace with your logic for generating successors)
successor(State, Successors) :-
  findall((Action, NextState), (action(Action, State, NextState)), Successors).

% Best-first search algorithm
best_first_search(StartState, GoalState, Solution) :-
  open_set([state(StartState, 0, nil)]),  % List of states with f-score (cost+heuristic) and parent
  closed_set([]),
  best_first_search_helper(open_set, closed_set, GoalState, Solution).

best_first_search_helper([], _, _, fail).
best_first_search_helper(OpenSet, ClosedSet, GoalState, [Action | Solution]) :-
  % Select state with the lowest f-score from the open set
  select_lowest_f(OpenSet, State),
  extract_state(State, CurrentState, _, _),

  % Check if goal state is reached
  (CurrentState = GoalState -> ! ; true),

  % Remove state from open set and add it to closed set
  delete(OpenSet, State, NewOpenSet),
  add_to_closed(ClosedSet, State),

  % Generate successors for the current state
  successor(CurrentState, Successors),

  % Update or add successors to the open set with f-scores
  update_open_set(NewOpenSet, ClosedSet, Successors, GoalState).

% Helper functions
select_lowest_f([State | _], State) :- !.
select_lowest_f([State1, State2 | Rest], Lowest) :-
  extract_state(State1, _, F1, _),
  extract_state(State2, _, F2, _),
  F1 < F2,
  !,
  select_lowest_f([State1 | Rest], Lowest).
select_lowest_f(OpenSet, State) :-
  select_lowest_f(OpenSet, State, inf).

extract_state(state(State, FScore, Parent), State, FScore, Parent).

add_to_closed(ClosedSet, State) :-
  \+ member(State, ClosedSet),
  append(ClosedSet, [State], NewClosedSet).

update_open_set(OpenSet, ClosedSet, Successors, GoalState) :-
  update_open_set(OpenSet, ClosedSet, Successors, GoalState, []).

update_open_set(_, _, [], _, Solution).
update_open_set(OpenSet, ClosedSet, [Successor(Action, NextState) | Rest], GoalState, Solution0) :-
  (member(state(NextState, _, _), ClosedSet) ->
    % Skip state if already in closed set
    update_open_set(OpenSet, ClosedSet, Rest, GoalState, Solution0) ;
   true),

  % Calculate f-score (cost + heuristic)
  heuristic(NextState, H),
  G is OpenSet!! 1,  % Get the cost (G-value) of the parent from the open set
  F is G + 1 + H,  % Assume a cost of 1 for each action, adjust as needed

  % Check if state exists in the open set
  (member(state(NextState, OldF, _), OpenSet) ->
    (OldF > F ->
      % Update state with lower f-score in the open set
      delete(OpenSet, state(NextState, OldF, _), NewOpenSet),
      update_open_set(NewOpenSet, ClosedSet, Rest, GoalState, [Action | Solution0]) ;
     true) ;
   
% Add state to the open set with its f-score and parent
append(OpenSet, [state(NextState, F, CurrentState)], NewOpenSet),
update_open_set(NewOpenSet, ClosedSet, Rest, GoalState, [Action | Solution0]).

% Operator notation for efficiency (optional)
OpenSet !! 1 --> nth_element(1, OpenSet, State), extract_state(State, _, Cost, _).

% Example usage (replace with your actual start and goal states)
start_state(state(at(home))).
goal_state(state(at(work))).

query(best_first_search(StartState, GoalState, Solution)).
