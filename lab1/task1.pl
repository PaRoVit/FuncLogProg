% Рожков Павел М8О-203Б-23 
% вар18(подсчёт числа вхождения заданного элемента в список)
% вар3(вычисление максимального элемента)
length([], 0).
length([_|T], X):-length(T, X1),X is X1+1.

% проверка вхождения рекурсивно
member(X, [X|_]).
member(X, [_|T]):-member(X, T).

% конкатенация
append([], X, X).
append([A|X], Y, [A|Z]):-append(X, Y, Z).

% удаление из списка
remove(X, [X|T], T).
remove(X, [Y|T], [Y|T1]):-remove(X, T, T1).

% перестановки списка
permute([],[]).
permute(L,[X|T]):-remove(X, L, R),permute(R, T).

% подсписок
sublist([], _).
sublist(S, L):-append(_, L1, L), append(S, _, L1).

% подсчёт вхождения без стандартный предикатов
counter([],_,0).
counter([X|T], X, N):-counter(T,X,N1), N is N1+1.
counter([_|T], X, N):-counter(T,X,N).

% подсчёт с использованием стандартных предикатов
counter1([],_,0).
counter1(L, X, N):-findall(X, member(X, L), F), length(F, N).

% нахождение максимального элемента
max([M], M).
max([H|T], M):-max(T, M1), (H > M1 -> M = H; M = M1).

% нахождение максимума с использованием стандартных предикатов
max1([M], M).
max1(L, M):-remove(H, L, R), max1(R, M1), (H > M1 -> M = H; M = M1).