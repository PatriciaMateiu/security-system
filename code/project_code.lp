

agent(james).

room(hallway).
room(livingroom).


event(enterGeneralPasscode(A)) :- agent(A).
event(enter(A,R)) :- agent(A), room(R).

fluent(inRoom(A,R)) :- agent(A), room(R).
fluent(alarmActivated(R)) :- room(R).


event(enterPasscode(A,R)) :- agent(A), room(R).
event(correctPasscode()).
event(wrongPasscode()).
fluent(defuseAlarm(R)) :- room(R).
fluent(startAlarm(R)) :- room(R).

event(defuseGeneralAlarm()).

event(startCamera(R)) :- room(R).

event(walk(A,R1,R2)) :- agent(A), room(R1), room(R2).


initiates(enter(A,R), inRoom(A,R), T) :- agent(A), room(R), time(T).


:- holdsAt(defuseAlarm(R), T), holdsAt(alarmActivated(R), T).

initiates(correctPasscode(), defuseAlarm(R), T) :- holdsAt(inRoom(A,R), T), room(R), time(T).
initiates(wrongPasscode(), startAlarm(R), T) :- holdsAt(inRoom(A,R), T), room(R), time(T).


terminates(correctPasscode(), alarmActivated(R), T) :- holdsAt(inRoom(A,R), T), room(R), time(T).


:- happens(correctPasscode(), T), happens(wrongPasscode(R), T).

:- happens(enterGeneralPasscode(A), T), happens(enterPasscode(A,R), T).


happens(enterGeneralPasscode(A), T) | happens(enterPasscode(A,R), T) :- happens(enter(A,R), T-1), holdsAt(alarmActivated(R), T-1).

happens(correctPasscode(), T) | happens(wrongPasscode(), T) :- happens(enterPasscode(A,R), T-1).
happens(correctPasscode(), T) | happens(wrongPasscode(), T) :- happens(enterGeneralPasscode(A), T-1).

happens(defuseGeneralAlarm(), T) :- happens(enterGeneralPasscode(A), T), happens(correctPasscode(), T).

terminates(defuseGeneralAlarm(), alarmActivated(R), T) :- room(R), time(T).

happens(enter(A, R2), T) :- happens(walk(A,R1,R2), T-1).


terminates(walk(A,R1,R2),inRoom(A,R1),T) :- R1!=R2, agent(A), room(R1), room(R2), time(T).


initiates(defuseGeneralAlarm(), defuseAlarm(R), T) :- room(R), time(T).
terminates(defuseGeneralAlarm(), startAlarm(R), T) :- room(R), time(T).


happens(startCamera(R), T) :- holdsAt(startAlarm(R), T).




holdsAt(alarmActivated(hallway), 0).
holdsAt(alarmActivated(livingroom), 0).

:- holdsAt(inRoom(james, hallway), 0).
:- holdsAt(inRoom(james, livingroom), 0).
:- holdsAt(recorded(hallway), 0).


:- holdsAt(defuseGeneralAlarm(), 0).
:- holdsAt(defuseAlarm(hallway), 0).
:- holdsAt(startAlarm(hallway), 0).
:- holdsAt(defuseAlarm(livingroom), 0).
:- holdsAt(startAlarm(livingroom), 0).


happens(enter(james, hallway), 1).

happens(walk(james, hallway, livingroom), 4).




:- releasedAt(F,0), fluent(F).

