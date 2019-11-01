aluno(joao, paradigmas).
aluno(maria, paradigmas).
aluno(joel, lab2).
aluno(joel, estruturas).

frequenta(joao, feup).
frequenta(maria, feup).
frequenta(joel, ist).

professor(carlos, paradigmas).
professor(ana_paula, estruturas).
professor(pedro, lab2).

funcionario(carlos, feup).
funcionario(ana_paula, feup).
funcionario(pedro, ist).


alunos(Professor, Estudante) :-
    aluno(Estudante, Aula),
    professor(Professor, Aula),
    frequenta(Estudante, Universidade),
    funcionario(Professor, Universidade).

universidade(Universidade, Pessoa) :-
    frequenta(Pessoa, Universidade);
    funcionario(Pessoa, Universidade).

colega(Pessoa1, Pessoa2) :-
    (
        aluno(Pessoa1, Aula), aluno(Pessoa2, Aula);
        frequenta(Pessoa1, Universidade), frequenta(Pessoa2, Universidade);
        funcionario(Pessoa1, Universidade), funcionario(Pessoa2, Universidade)
    ),
    Pessoa1 \= Pessoa2.
