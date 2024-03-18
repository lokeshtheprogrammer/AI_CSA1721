rule(can_fly, has_wings).
rule(can_fly, is_a(bird)).
rule(has_wings, fact(bird)).
rule(is_a(X), fact(X)).  fact(bird).
fact(penguin).

backward_chain(Goal, Proof) :-
  rule(Goal, Premise),
  backward_chain(Premise, [Goal | Proof]).
backward_chain(fact(X), [fact(X)]).

% Example usage
query(backward_chain(can_fly(penguin), Proof)).

