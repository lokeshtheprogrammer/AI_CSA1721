% Defining parent-child relationships
parent(john, michael).
parent(john, sarah).
parent(jane, michael).
parent(jane, sarah).
parent(michael, kevin).
parent(michael, lily).
parent(sarah, daisy).

% Defining male and female
male(john).
male(michael).
male(kevin).
female(jane).
female(sarah).
female(lily).
female(daisy).

% Defining grandparent relationship
grandparent(Grandparent, Grandchild) :-
    parent(Grandparent, Child),
    parent(Child, Grandchild).

% Defining sibling relationship
sibling(SiblingOne, SiblingTwo) :-
    parent(Parent, SiblingOne),
    parent(Parent, SiblingTwo),
    SiblingOne \= SiblingTwo.

% Defining aunt relationship
aunt(Aunt, NieceNephew) :-
    female(Aunt),
    parent(Parent, NieceNephew),
    sibling(Parent, Aunt).
