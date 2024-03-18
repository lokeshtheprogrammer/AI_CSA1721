rule(fact(bird), has_wings).
rule(fact(bird), can_fly).
rule(has_wings, can_fly).  fact(bird).
fact(penguin).  forward_chain(Goal, Proof) :-
  rule(Premise, Conclusion),
  forward_chain(Premise, [Conclusion | Proof]).
forward_chain(fact(X), [fact(X)]).

% Example usage
query(forward_chain(can_fly, Proof)).

