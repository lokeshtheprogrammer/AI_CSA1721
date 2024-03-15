% Define birds and whether they can fly or not
bird(eagle).
bird(penguin).
bird(ostrich).
bird(sparrow).

% Define which birds can fly
can_fly(Bird) :- bird(Bird), not(flightless_bird(Bird)).

% Define flightless birds
flightless_bird(penguin).
flightless_bird(ostrich).

% Queries
% To check if a bird can fly, use:
% ?- can_fly(eagle).
% To check if a bird cannot fly, use:
% ?- \+ can_fly(penguin).
   output 
    c:/Users/aimpr/Downloads/movie time/OneDrive/Documents/Prolog/birdfly.pl compiled 0.00 sec, 0 clauses
?-  can_fly(eagle).
true.

?- 
