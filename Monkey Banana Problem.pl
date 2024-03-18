monkey(at(left), has(empty_hand)).
banana(at(right)).

action(climb, monkey(at(left), Hand), monkey(at(right), Hand)) :-
  monkey(at(left), _).  % Monkey can only climb if it's on the left side

action(descend, monkey(at(right), has(Hand)), monkey(at(left), Hand)) :-
  monkey(at(right), Hand).  % Monkey can only descend if it's on the right side

action(take, monkey(at(right), has(empty_hand)), monkey(at(right), has(banana))) :-
  banana(at(right)),  % Monkey can take the banana only if it's on the right side with an empty hand
  monkey(at(right), has(empty_hand)).

plan([], State).
plan([Action | Rest], FinalState) :-
  action(Action, CurrentState, NextState),
  plan(Rest, NextState),
  InitialState = CurrentState.

solve(InitialState, GoalState, Plan) :-
  plan(Plan, GoalState),
  InitialState = CurrentState,
  plan([Action | _], CurrentState),
  action(Action, CurrentState, _).

% Example usage
initial_state(monkey(at(left), has(empty_hand))).
goal_state(monkey(at(left), has(banana))).

solve(initial_state, GoalState, Plan),
write('Plan to get the banana: '), write(Plan).

