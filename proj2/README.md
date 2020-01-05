# Grupo Gap Puzzle_2

## Instruções de Execução
1. Consultar o ficheiro gap.pl

### Resolver um puzzle existente
 * ````solve_puzzle(Number, Board)```` - resolve um puzzle com as opções default de labeling
 * ````labeling_test(Number, Options, Iterations)```` - testar a execução do solver com diferentes opções de labeling

### Gerar novos puzzles
 * ````generate1(PuzzleNumber, Size, NumHints)```` - resolve um puzzle vazio escolhendo as variáveis e valores de forma aleatória, execução mais rápida para puzzles de pequena dimensão
 * ````generate2(PuzzleNumber, Size, NumHints)```` - gera pistas aleatórias e tenta resolver o puzzle resultante mas nem sempre tem solução, indicado para puzzles de grandes dimensões com poucas pistas