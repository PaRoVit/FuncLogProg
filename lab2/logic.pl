% Все дни недели 
day(monday).
day(tuesday).
day(wednesday).
day(thursday).
day(friday).
day(saturday).
day(sunday).

% Какой день за каким идёт 
next_day(monday, tuesday).
next_day(tuesday, wednesday).
next_day(wednesday, thursday).
next_day(thursday, friday).
next_day(friday, saturday).
next_day(saturday, sunday).
next_day(sunday, monday).

% Расписание магазинов 
open(shoe, Day) :- member(Day, [tuesday, wednesday, thursday, friday, saturday]).
open(hardware, Day) :- member(Day, [monday, wednesday, thursday, friday, saturday]).
open(grocery, Day) :- member(Day, [monday, tuesday, wednesday, friday, saturday]).
open(perfume, Day) :- member(Day, [monday, wednesday, friday]).

% Проверяем, что все магазины работают в определённый день
all_stores_open(Day) :-
    open(shoe, Day),
    open(hardware, Day),
    open(grocery, Day),
    open(perfume, Day).

% Поиск необходимого дня (так как все разом пошли, значит в этот день должны быть открыты все магазы, это первый такой день на неделе)
find_first_day(AllOpenDay) :-
    day(AllOpenDay),
    all_stores_open(AllOpenDay),
    !.  

% У клавы известно что её магазин открыт вчера и позавчера
klava_cond(Day, Store) :- 
    day(Day),
    day(Yesterday),
    day(DayBeforeYesterday),
    next_day(Yesterday, Day),
    next_day(DayBeforeYesterday, Yesterday),
    open(Store, Yesterday),
    open(Store, DayBeforeYesterday).

% У жени известно что её магаз открыт вчера и завтра
jenya_cond(Day, Store) :-
    day(Day),
    day(Yesterday),
    day(Tomorrow),
    next_day(Yesterday, Day),
    next_day(Day, Tomorrow),
    open(Store, Yesterday),
    open(Store, Tomorrow).

% У иры известно что сегодня её магаз открыт, а завтра закрыт
ira_cond(Day, Store) :-
    day(Day),
    day(Tomorrow),
    next_day(Day, Tomorrow),
    open(Store, Day),
    \+ open(Store, Tomorrow).

% при помощи всех комбинаций выбираем те, что удовлетворяют нашим условиям. то есть кондициям девчонок
solve(Asya, Jenya, Ira, Klava, Day) :-
    permutation([Asya, Jenya, Ira, Klava], [shoe, hardware, grocery, perfume]),
    find_first_day(Day),
    klava_cond(Day, Klava),
    jenya_cond(Day, Jenya),
    ira_cond(Day, Ira)
    .
    