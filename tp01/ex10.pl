comprou(joao, honda).
comprou(joao, uno).

ano(honda, 1997).
ano(uno, 1998).

valor(honda, 20000).
valor(uno, 7000).

pode_vender(Pessoa, Carro, AnoAtual) :-
    comprou(Pessoa, Carro),
    ano(Carro, AnoDeCompra),
    (AnoAtual - AnoDeCompra) =< 10,
    valor(Carro, Valor),
    Valor < 10000.