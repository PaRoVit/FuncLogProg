% Рожков Павел М8О-203Б-23
% вар 2(файл two.pl)
        % Для каждого студента, найти средний балл, и сдал ли он экзамены или нет
        % Для каждого предмета, найти количество не сдавших студентов
        % Для каждой группы, найти студента (студентов) с максимальным средним баллом

:- ['FuncLogProg/lab1/two.pl'].

% сумма оценок
sum([], 0).
sum([H|T], Sum):-sum(T,R), Sum is H + R.

% для нахождения минимальной оценки
min([M], M).
min([H|T], M):-min(T, M1), (H < M1 -> M = H; M = M1).

% нахождение максимального элемента
max([M], M).
max([H|T], M):-max(T, M1), (H > M1 -> M = H; M = M1).

% подсчёт количества вхождений
counter([],_,0).
counter([X|T], X, N):-counter(T,X,N1), N is N1+1.
counter([_|T], X, N):-counter(T,X,N).

% средний балл для каждого студента
average(Student, Avg, Ok):-
    findall(Grade, grade(_, Student, _, Grade), Grades), sum(Grades, Sum), length(Grades, Len), Avg is Sum / Len, 
    min(Grades, Min),(Min > 2 -> Ok = 'passed'; Ok = 'didn`t pass').

% подсчёт количества несдавших для каждого предмета
count_not_passed(Subject, Count):- 
    findall(Grade, grade(_, _, Subject, Grade), Grades), counter(Grades, 2, Count).

% поиск максимальным средним баллом
max_avg_student([], _, _, _):- fail.
max_avg_student([Student], Student, Avg, Avg). 
max_avg_student([Student1, Student2|Rest], MaxStudent, MaxAvg, TempAvg) :-
    average(Student1, Avg1, _),
    average(Student2, Avg2, _),
    (Avg1 >= Avg2 -> max_avg_student([Student1|Rest], MaxStudent, MaxAvg, Avg1); max_avg_student([Student2|Rest], MaxStudent, MaxAvg, Avg2)).

% Предикат для нахождения студента с максимальным средним баллом в группе
max_average_student(Group, MaxStudent, MaxAvg) :-
    findall(Student, grade(Group, Student, _, _), Students),  % Собираем всех студентов в группе
    max_avg_student(Students, MaxStudent, MaxAvg, 0).
