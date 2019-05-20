## Tic-Tac-Toe Haskell
> Tested in Glasgow Haskell Compiler (as ghci) in a Debian environment within Windows 10 64x

> **Portuguese**

## Características

Há três modos de jogar:

- Jogador Vs Jogador
- Jogador Vs Máquina (modo fácil)
- Jogador Vs Máquina (modo médio)
- Jogador Vs Máquina (modo difícil)

## Jogador Vs Jogador

Ao escolher Jogador Vs Jogador, o jogo iniciará com o jogador 1, que será questionado a posição desejada, e em seguida o jogador 2, e continuamente até o fim.

## Jogador Vs Máquina (modo fácil)

Ao escolher Jogador Vs Máquina (modo fácil), o jogo iniciará com o jogador 1, que será questionado a posição desejada, e em seguida, a máquina. Antes da jogada da máquina, o usuário será solicitado apertar a tecla "Enter" antes da jogada, em seguida, a máquina escolherá a primeira posição possível, e o jogo voltará ao jogador 1 e assim sucessivamente até o final.

## Jogador Vs Máquina (modo médio)

Ao escolher Jogador Vs Máquina (modo médio), o jogo iniciará com o jogador 1, que será questionado a posição desejada, e em seguida, a máquina. Antes da jogada da máquina, o usuário será solicitado apertar a tecla "Enter" antes da jogada, em seguida, a máquina escolherá um número aleatório que esteja disponível e voltará ao jogador 1 e assim sucessivamente até o final.

## Jogador Vs Máquina (modo difícil)

Ao escolher Jogador Vs Máquina (modo difícil), o jogo iniciará com o jogador 1, que será questionado a posição desejada, e em seguida, a máquina. Antes da jogada da máquina, o usuário será solicitado apertar a tecla "Enter" antes da jogada, em seguida, a máquina verificará se e é a sua primeira posição, caso seja, verificará se o jogador colocou em qualquer posição nas pontas, caso seja verdadeiro, escreverá na posição central, o mesmo acontecerá caso o jogador coloque nas laterais. Caso o jogador tenha iniciado na posição central, escreverá em uma das pontas.
Na próxima jogada da máquina, encontra-se toda a lógica principal que definirá se a máquina ganhará ou não. Toda a lógica foi desenvolvida a partir da explicação encontrada em: [Quora](https://www.quora.com/Is-there-a-way-to-never-lose-at-Tic-Tac-Toe).

----
## Tic-Tac-Toe Haskell

> **English**

## Characteristics

There are three playing ways:

- Player Vs Player.
- Player Vs Machine (Easy).
- Player Vs Machine (Normal).
- Player Vs Machine (Hard).

## Player Vs Player

When choosing Player Vs Player, the game will start with Player 1, who will be prompted the desired position, afterwards Player 2 will be prompted and so forth until the game is over.

## Player Vs Machine (Easy)

When choosing Player Vs Machine (Easy), the game will start with Player 1, who will be prompted the desired position, afterwards the machine will be up to play. Before its move, the user will be prompted to enter "Enter" key before proceeding. Then, the machine will choose the first available position and then game will then go back to Player 1 and so forth until the game is over.

## Player Vs Machine (Normal)

When choosing Player Vs Machine (Normal), the game will start with Player 1, who will be prompted the desired position, afterwards the machine will be up to play. Before its move, the user will be prompted to enter "Enter" key before proceeding. Then, the machine will choose a random available position and then game will then go back to Player 1 and so forth until the game is over.

## Player Vs Machine (Hard)

When choosing Player Vs Machine (Normal), the game will start with Player 1, who will be prompted the desired position, afterwards the machine will be up to play. Before its move, the user will be prompted to enter "Enter" key before proceeding. Then, the machine will verify whether it is its first movement, if so, it will then check whether the player has chosen any edges, if so, will write in the center position. The same procedure will happen if the user has chosen any corner position. If the player has started in the center position, then the machine will write in any edge.
In the next machine movement, the main logic if found which will define whether the machine will win or not. This logic was developed according to the following answer: [Quora](https://www.quora.com/Is-there-a-way-to-never-lose-at-Tic-Tac-Toe)

----
## Changelog
* 20-May-2019 Initial Files

----
## Thanks
* [Philip JF](https://stackoverflow.com/questions/5852722/replace-individual-list-elements-in-haskell)
* [Arjun Mani](https://www.quora.com/Is-there-a-way-to-never-lose-at-Tic-Tac-Toe)

---
## License

![License](http://img.shields.io/:license-mit-blue.svg?style=flat-square)](http://badges.mit-license.org)

- **[MIT license](http://opensource.org/licenses/mit-license.php)**
- Copyright 2019 © <a href="https://github.com/alefduarte" target="_blank">Alef Duarte</a> and <a href="https://github.com/marinabsz" target="_blank">Marina Batista</a>.
