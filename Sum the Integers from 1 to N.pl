
sum(1, N, N).
sum(X, N, Sum) :-
  X < N,
  NewX is X + 1,
  sum(NewX, N, TempSum),
  Sum is TempSum + X.

