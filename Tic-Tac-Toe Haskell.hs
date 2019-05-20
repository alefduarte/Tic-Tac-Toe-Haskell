-- |Usado para gerar número aleatório
import System.Random
-- |Vetor inicial
numbers :: IO ()
numbers =
    putStrLn "\t\t  1 | 2 | 3 \n \
    \\t\t-------------\n \
    \\t\t  4 | 5 | 6 \n \
    \\t\t-------------\n \
    \\t\t  7 | 8 | 9 \n"

-- |Limpar tela
limpar :: IO ()
limpar = putStr "\ESC[2J"

-- |replaceNth {posição a ser alterada} {novo valor} {vetor original} --> {vetor alterado}
-- |https://stackoverflow.com/questions/5852722/replace-individual-list-elements-in-haskell
replaceNth :: Int -> a -> [a] -> [a]
replaceNth _ _ [] = []
replaceNth n newVal (x:xs)
    | n == 0 = newVal:xs
    | otherwise = x:replaceNth (n-1) newVal xs

-- |Gera um número aleatório do tipo IO int
-- |randomInt {limite inferior} {limite superior} {Número aleatório do tipo IO Int}
randomInt :: Int -> Int -> IO Int
randomInt x y =
    randomRIO (x, y)

-- |Preenche a primeira posição vazia do vetor
-- |firstEmpty {primeira posição, inicialmente 0}{valor a ser inserido, X ou O} {vetor original} -> {vetor alterado}
firstEmpty :: Int->String->[String]->[String]
firstEmpty pos value arr
    | (arr !! pos) == " " = replaceNth pos value arr
    | otherwise = firstEmpty (pos+1) value arr


imprimir :: [String] -> IO ()
imprimir arr = 
        putStrLn ("\n\t\t  " ++ arr !! 0 ++ " | " ++ arr !! 1 ++ " | "  ++ arr !! 2 ++ "\n\
        \\t\t-------------\n\
        \\t\t  " ++ arr !! 3 ++ " | " ++ arr !! 4 ++ " | " ++ arr !! 5 ++ "\n\
        \\t\t-------------\n\
        \\t\t  " ++ arr !! 6 ++ " | " ++ arr !! 7 ++ " | " ++ arr !! 8 ++ "\n")
    
-- |Menu principal
menu :: IO() 
menu = putStrLn "\n\t\tJOGO DA VELHA\t\t\t\n\n\
    \\t\t+-----------------------------------------------+\n\
    \\t\t|  Escolha uma opção:                         \t|\n\
    \\t\t|\t1. Jogador Vs Jogador.                  |\n\
    \\t\t|\t2. Jogador Vs Máquina (modo fácil).     |\n\
    \\t\t|\t3. Jogador Vs Máquina (modo médio).     |\n\
    \\t\t|\t4. Jogador Vs Máquina (modo difícil).   |\n\
    \\t\t|\t5. Sair.                                |\n\
    \\t\t+-----------------------------------------------+\n\
    \\t\t\tOpção: "

-- |replaceNth {vetor atual} -> {resultado das verificações}
verifica :: [String] -> Bool
verifica arr
    -- |teste horizontal
    | arr !! 0 == arr !! 1 && arr !! 1 == arr !! 2 && arr !! 0 /= " " = True
    | arr !! 3 == arr !! 4 && arr !! 4 == arr !! 5 && arr !! 3 /= " " = True
    | arr !! 6 == arr !! 7 && arr !! 7 == arr !! 8 && arr !! 6 /= " " = True
    -- |teste vertical
    | arr !! 0 == arr !! 3 && arr !! 3 == arr !! 6 && arr !! 0 /= " " = True
    | arr !! 1 == arr !! 4 && arr !! 4 == arr !! 7 && arr !! 1 /= " " = True
    | arr !! 2 == arr !! 5 && arr !! 5 == arr !! 8 && arr !! 2 /= " " = True
    -- |teste diagonal
    | arr !! 0 == arr !! 4 && arr !! 4 == arr !! 8 && arr !! 0 /= " " = True
    | arr !! 2 == arr !! 4 && arr !! 4 == arr !! 6 && arr !! 2 /= " " = True
    | otherwise = False


-- |Jogo 1 = Jogador Vs Jogador
-- |jogo1 {vetor atual} {quantidade de jogadas, sendo == 9 velha} {jogador atual, 1 ou 2}
jogo1 :: [String] -> Int -> Int -> IO ()
jogo1 arr jogada jogador
    -- |verifica se o jogo terminou
    | verifica arr == True = do 
        -- |por verificar antes da próxima jogada, caso o jogador atual seja 1, a jogada vencedora foi feita pelo jogador anterior 2 ou vice versa
        if (jogador == 1)
            then putStrLn "Jogador 2 (O) ganhou\n"
        else putStrLn "Jogador 1 (X) ganhou\n"
    -- |caso tenha feito 9 jogadas ou mais, o jogo termina
    | jogada >= 9 = putStrLn "VELHA - Não houve vencedores\n"
    -- |caso seja o primeiro jogador
    | jogador == 1 = do
        -- |imprime na tela as posições disponíveis 
        numbers
        putStrLn "Jogador 1 (X)"
        putStrLn "Escolha um número correspondente à posição desejada\n"
        -- |recebe a posição desejada
        pos <- readLn
        -- |limpa a tela
        limpar
        -- |se a posição escolhida não for vazia, impede a alteração 
        if ((arr !! (pos-1)) /= " ")
            then do 
                putStrLn "Posição já existe, tente novamente!!"
                -- |chama a função novamente com os mesmos parâmetros sem alterar o arr
                jogo1 arr jogada 1
            else do
                -- |imprime como o vetor ficará, (pos-1) pois o vetor começa em 0
                imprimir (replaceNth (pos-1) "X" arr)
                -- |chama a função novamente com o arr alterado como parâmetro, aumentando o contador de jogada e mudando para o jogador 2
                jogo1 (replaceNth (pos-1) "X" arr) (jogada+1) 2
    -- |caso seja jogador dois, realiza os mesmos processos tal como o jogador 1
    | jogador == 2 = do
        numbers
        putStrLn "Jogador 2 (O)"
        putStrLn "Escolha um número correspondente à posição desejada\n"
        -- |recebe a posição desejada
        pos <- readLn
        -- |limpa a tela
        limpar
        if ((arr !! (pos-1)) /= " ")
            then do 
                putStrLn "Posição já existe, tente novamente!!"
                jogo1 arr jogada 2
            else do
                -- |imprime como o vetor ficará, (pos-1) pois o vetor começa em 0
                imprimir (replaceNth (pos-1) "O" arr)
                jogo1 (replaceNth (pos-1) "O" arr) (jogada+1) 1      
        

-- |Jogo 2 = Jogador Vs Máquina (modo fácil)
-- |jogo2 {vetor atual} {quantidade de jogadas, sendo == 9 velha} {jogador atual, 1 ou 2} {posição da máquina}
jogo2 :: [String] -> Int -> Int -> Int -> IO ()
jogo2 arr jogada jogador maq
    -- |verifica se o jogo terminou
    | verifica arr == True = do 
        -- |por verificar antes da próxima jogada, caso o jogador atual seja 1, a jogada vencedora foi feita pela máquina ou vice versa
        if (jogador == 1)
            then putStrLn "Máquina (O) ganhou\n"
        else putStrLn "Jogador 1 (X) ganhou\n"
    -- |caso tenha feito 9 jogadas ou mais, o jogo termina
    | jogada >= 9 = putStrLn "VELHA - Não houve vencedores\n"
    -- |caso seja o primeiro jogador
    | jogador == 1 = do
        -- |imprime na as posições disponíveis 
        numbers
        putStrLn "Jogador 1 (X)"
        putStrLn "Escolha um número correspondente à posição desejada\n"
        -- |recebe a posição desejada
        pos <- readLn
        -- |limpa a tela
        limpar
        -- |se a posição escolhida não for vazia, impede a alteração 
        if ((arr !! (pos-1)) /= " ")
            then do 
                putStrLn "Posição já existe, tente novamente!!"
                -- |chama a função novamente com os mesmos parâmetros sem alterar o arr
                jogo2 arr jogada 1 maq
            else do
                -- |imprime como o vetor ficará, (pos-1) pois o vetor começa em 0
                imprimir (replaceNth (pos-1) "X" arr)
                -- |chama a função novamente com o arr alterado como parâmetro, aumentando o contador de jogada e mudando para o jogador 2
                jogo2 (replaceNth (pos-1) "X" arr) (jogada+1) 2 maq
    -- |caso seja a máquina, aumenta o contador "maq" e vefica se esta posição já está ocupada
    | jogador == 2 = do
        -- |verifica se a posição atual do contador "maq" esta vazia no vetor
        if ((arr !! maq) /= " ")
            -- |caso esteja, chama a função novamente aumentando o contador
            then do 
                jogo2 arr jogada 2 (maq+1)
            else do
                -- |caso a posição esteja disponível, pede o usuário para pressionar enter antes de prosseguir
                putStrLn "Maquina\nAperte enter para continuar"
                -- |recebe a tecla enter
                esc <- getChar
                -- |retorna a tecla enter na tela, caso a variável nao fosse usada retornaria erro
                return esc
                -- |limpa a tela
                limpar
                -- |imprime como o vetor ficará
                imprimir (replaceNth maq "O" arr)
                -- |chama a função novamente com o arr alterado como parâmetro, aumentando o contador de jogada, mudando para o jogador 1 e aumentando o contador "maq"
                jogo2 (replaceNth maq "O" arr) (jogada+1) 1 (maq+1)


-- |Jogo 3 = Jogador Vs Máquina (modo médio)
-- |jogo3 {vetor atual} {quantidade de jogadas, sendo == 9 velha} {jogador atual, 1 ou 2} {posição da máquina}
jogo3 :: [String] -> Int -> Int -> Int -> IO ()
jogo3 arr jogada jogador rand
    -- |verifica se o jogo terminou
    | verifica arr == True = do 
        -- |por verificar antes da próxima jogada, caso o jogador atual seja 1, a jogada vencedora foi feita pela máquina ou vice versa
        if (jogador == 1)
            then putStrLn "Máquina (O) ganhou\n"
        else putStrLn "Jogador 1 (X) ganhou\n"
    -- |caso tenha feito 9 jogadas ou mais, o jogo termina
    | jogada >= 9 = putStrLn "VELHA - Não houve vencedores\n"
    -- |caso seja o primeiro jogador
    | jogador == 1 = do
        -- |imprime na as posições disponíveis 
        numbers
        putStrLn "Jogador 1 (X)"
        putStrLn "Escolha um número correspondente à posição desejada\n"
        -- |recebe a posição desejada
        pos <- readLn
        -- |limpa a tela
        limpar
        -- |se a posição escolhida não for vazia, impede a alteração 
        if ((arr !! (pos-1)) /= " ")
            then do 
                putStrLn "Posição já existe, tente novamente!!"
                -- |chama a função novamente com os mesmos parâmetros sem alterar o arr
                jogo3 arr jogada 1 rand
            else do
                -- |imprime como o vetor ficará, (pos-1) pois o vetor começa em 0
                imprimir (replaceNth (pos-1) "X" arr)
                -- |chama a função novamente com o arr alterado como parâmetro, aumentando o contador de jogada e mudando para o jogador 2
                jogo3 (replaceNth (pos-1) "X" arr) (jogada+1) 2 rand
    -- |caso seja a máquina, gera um número aleatório "rand" e verifica se esta posição já está ocupada
    | jogador == 2 = do
        -- |gera um número aleatório de 0 a 9 do tipo IO Int e converte-o para Int
        rand <- randomInt 0 8
        -- |verifica se o número aleatório está vazio no vetor
        if ((arr !! rand) /= " ")
            -- |caso esteja, chama a função novamente
            then do
                jogo3 arr jogada 2 rand
            else do
                -- |caso a posição esteja disponível, pede o usuário para pressionar enter antes de prosseguir
                putStrLn "Maquina\nAperte enter para continuar"
                -- |recebe a tecla enter
                esc <- getChar
                -- |retorna a tecla enter na tela, caso a variável nao fosse usada retornaria erro
                return esc
                -- |limpa a tela
                limpar
                -- |imprime como o vetor ficará
                imprimir (replaceNth rand "O" arr)
                -- |chama a função novamente com o arr alterado como parâmetro, aumentando o contador de jogada, mudando para o jogador 1 e uma posição aleatória
                jogo3 (replaceNth rand "O" arr) (jogada+1) 1 rand
 

-- |Jogo 4 = Jogador Vs Máquina (modo difícil)
-- |https://www.quora.com/Is-there-a-way-to-never-lose-at-Tic-Tac-Toe
-- |jogo4 {vetor atual} {quantidade de jogadas, sendo == 9 velha} {jogador atual, 1 ou 2}
jogo4 :: [String] -> Int -> Int -> IO ()
jogo4 arr jogada jogador
    -- |verifica se o jogo terminou
    | verifica arr == True = do 
        -- |por verificar antes da próxima jogada, caso o jogador atual seja 1, a jogada vencedora foi feita pela máquina ou vice versa
        if (jogador == 1)
            then putStrLn "Máquina (O) ganhou\n"
        else putStrLn "Jogador 1 (X) ganhou\n"
    -- |caso tenha feito 9 jogadas ou mais, o jogo termina
    | jogada >= 9 = putStrLn "VELHA - Não houve vencedores\n"
    -- |caso seja o primeiro jogador
    | jogador == 1 = do
        -- |imprime na as posições disponíveis 
        numbers
        putStrLn "Jogador 1 (X)"
        putStrLn "Escolha um número correspondente à posição desejada\n"
        -- |recebe a posição desejada
        pos <- readLn
        -- |limpa a tela
        limpar
        -- |se a posição escolhida não for vazia, impede a alteração 
        if ((arr !! (pos-1)) /= " ")
            then do 
                putStrLn "Posição já existe, tente novamente!!"
                -- |chama a função novamente com os mesmos parâmetros sem alterar o arr
                jogo4 arr jogada 1
            else do
                -- |imprime como o vetor ficará, (pos-1) pois o vetor começa em 0
                imprimir (replaceNth (pos-1) "X" arr)
                -- |chama a função novamente com o arr alterado como parâmetro, aumentando o contador de jogada e mudando para o jogador 2
                jogo4 (replaceNth (pos-1) "X" arr) (jogada+1) 2
    -- |caso seja a máquina, escolhe a melhor opção ou impede que o jogador ganhe
    | jogador == 2 = do
        -- |pede o usuário para pressionar enter antes de prosseguir
        putStrLn "Maquina\nAperte enter para continuar"
        -- |recebe a tecla enter
        esc <- getChar
        -- |retorna a tecla enter na tela, caso a variável nao fosse usada retornaria erro
        return esc
        -- |limpa a tela
        limpar
        -- |se é a primeira vez da máquina, escolhe a melhor opção inicial
        if (jogada == 1)
            -- |se o oponente escolher o centro, escreva imediatamente em qualquer ponta
            then if ((arr !! 4) /= " ")
                then do 
                    imprimir (replaceNth 0 "O" arr)
                    jogo4 (replaceNth 0 "O" arr) (jogada+1) 1
                -- |se o oponente escolher qualquer posição das pontas, coloque no centro
                else
                    if ((arr !! 0 /= " ") || (arr !! 2 /= " ") || (arr !! 6 /= " ") || (arr !! 8 /= " "))
                        then do 
                            imprimir (replaceNth 4 "O" arr)
                            jogo4 (replaceNth 4 "O" arr) (jogada+1) 1
                    -- |se o usuário escolheu um canto, marque no meio
                    else do 
                        imprimir (replaceNth 4 "O" arr)
                        jogo4 (replaceNth 4 "O" arr) (jogada+1) 1
        else
            -- |em seguida, verifica as posições para ganhar
            -- |verifica a primeira linha
            if ((arr !! 0 == "O") && (arr !! 2 == "O") && (arr !! 1 == " "))
                then do
                    imprimir (replaceNth 1 "O" arr)
                    jogo4 (replaceNth 1 "O" arr) (jogada+1) 1
                else
                    if ((arr !! 0 == "O") && (arr !! 1 == "O") && (arr !! 2 == " "))
                        then do
                            imprimir (replaceNth 2 "O" arr)
                            jogo4 (replaceNth 2 "O" arr) (jogada+1) 1
                    else
                        if ((arr !! 2 == "O") && (arr !! 1 == "O") && (arr !! 0 == " "))
                            then do
                                imprimir (replaceNth 0 "O" arr)
                                jogo4 (replaceNth 0 "O" arr) (jogada+1) 1
                        -- | verifica a primeira coluna
                        else
                            if ((arr !! 0 == "O") && (arr !! 6 == "O") && (arr !! 3 == " "))
                                then do
                                    imprimir (replaceNth 3 "O" arr)
                                    jogo4 (replaceNth 3 "O" arr) (jogada+1) 1
                            else
                                if ((arr !! 0 == "O") && (arr !! 3 == "O") && (arr !! 6 == " "))
                                    then do
                                        imprimir (replaceNth 6 "O" arr)
                                        jogo4 (replaceNth 6 "O" arr) (jogada+1) 1
                                else
                                    if ((arr !! 3 == "O") && (arr !! 6 == "O") && (arr !! 0 == " "))
                                        then do
                                            imprimir (replaceNth 0 "O" arr)
                                            jogo4 (replaceNth 0 "O" arr) (jogada+1) 1
                                    -- |verifica a terceira linha
                                    else
                                        if ((arr !! 6 == "O") && (arr !! 8 == "O") && (arr !! 7 == " "))
                                            then do
                                                imprimir (replaceNth 7 "O" arr)
                                                jogo4 (replaceNth 7 "O" arr) (jogada+1) 1
                                        else
                                            if ((arr !! 6 == "O") && (arr !! 7 == "O") && (arr !! 8 == " "))
                                                then do
                                                    imprimir (replaceNth 8 "O" arr)
                                                    jogo4 (replaceNth 8 "O" arr) (jogada+1) 1
                                                    else
                                                        if ((arr !! 7 == "O") && (arr !! 8 == "O") && (arr !! 6 == " "))
                                                            then do
                                                                imprimir (replaceNth 6 "O" arr)
                                                                jogo4 (replaceNth 6 "O" arr) (jogada+1) 1
                                                        -- |verifica terceira coluna
                                                        else
                                                            if ((arr !! 8 == "O") && (arr !! 2 == "O") && (arr !! 5 == " "))
                                                                then do
                                                                    imprimir (replaceNth 5 "O" arr)
                                                                    jogo4 (replaceNth 5 "O" arr) (jogada+1) 1
                                                            else
                                                                if ((arr !! 8 == "O") && (arr !! 5 == "O") && (arr !! 2 == " "))
                                                                    then do
                                                                        imprimir (replaceNth 2 "O" arr)
                                                                        jogo4 (replaceNth 2 "O" arr) (jogada+1) 1
                                                                else
                                                                    if ((arr !! 5 == "O") && (arr !! 2 == "O") && (arr !! 8 == " "))
                                                                        then do
                                                                            imprimir (replaceNth 8 "O" arr)
                                                                            jogo4 (replaceNth 8 "O" arr) (jogada+1) 1
                                                                    -- |verifica segunda coluna
                                                                    else
                                                                        if ((arr !! 1 == "O") && (arr !! 7 == "O") && (arr !! 4 == " "))
                                                                            then do
                                                                                imprimir (replaceNth 4 "O" arr)
                                                                                jogo4 (replaceNth 4 "O" arr) (jogada+1) 1
                                                                        else
                                                                            if ((arr !! 1 == "O") && (arr !! 4 == "O") && (arr !! 7 == " "))
                                                                                then do
                                                                                    imprimir (replaceNth 7 "O" arr)
                                                                                    jogo4 (replaceNth 7 "O" arr) (jogada+1) 1
                                                                            -- |verifica segunda linha
                                                                            else
                                                                                if ((arr !! 4 == "O") && (arr !! 5 == "O") && (arr !! 3 == " "))
                                                                                    then do
                                                                                        imprimir (replaceNth 3 "O" arr)
                                                                                        jogo4 (replaceNth 3 "O" arr) (jogada+1) 1
                                                                                else
                                                                                    if ((arr !! 3 == "O") && (arr !! 5 == "O") && (arr !! 4 == " "))
                                                                                        then do
                                                                                            imprimir (replaceNth 4 "O" arr)
                                                                                            jogo4 (replaceNth 4 "O" arr) (jogada+1) 1
                                                                                    -- |verifica diagonais
                                                                                    else
                                                                                        if ((arr !! 0 == "O") && (arr !! 4 == "O") && (arr !! 8 == " "))
                                                                                            then do
                                                                                                imprimir (replaceNth 8 "O" arr)
                                                                                                jogo4 (replaceNth 8 "O" arr) (jogada+1) 1
                                                                                        else
                                                                                            if ((arr !! 4 == "O") && (arr !! 8 == "O") && (arr !! 0 == " "))
                                                                                                then do
                                                                                                    imprimir (replaceNth 0 "O" arr)
                                                                                                    jogo4 (replaceNth 0 "O" arr) (jogada+1) 1
                                                                                            else
                                                                                                if ((arr !! 2 == "O") && (arr !! 6 == "O") && (arr !! 4 == " "))
                                                                                                    then do
                                                                                                        imprimir (replaceNth 4 "O" arr)
                                                                                                        jogo4 (replaceNth 4 "O" arr) (jogada+1) 1
                                                                                                else
                                                                                                    if ((arr !! 2 == "O") && (arr !! 4 == "O") && (arr !! 6 == " "))
                                                                                                        then do
                                                                                                            imprimir (replaceNth 6 "O" arr)
                                                                                                            jogo4 (replaceNth 6 "O" arr) (jogada+1) 1
                                                                                                    else
                                                                                                        if ((arr !! 6 == "O") && (arr !! 4 == "O") && (arr !! 2 == " "))
                                                                                                            then do
                                                                                                                imprimir (replaceNth 2 "O" arr)
                                                                                                                jogo4 (replaceNth 2 "O" arr) (jogada+1) 1
                                                                                                        -- |atrapalha o jogador a ganhar, verifica as posições que o usuário escolheu
                                                                                                        -- |verifica primeira linha
                                                                                                        else
                                                                                                            if ((arr !! 0 == "X") && (arr !! 2 == "X") && (arr !! 1 == " "))
                                                                                                                then do
                                                                                                                    imprimir (replaceNth 1 "O" arr)
                                                                                                                    jogo4 (replaceNth 1 "O" arr) (jogada+1) 1
                                                                                                                    else
                                                                                                                        if ((arr !! 0 == "X") && (arr !! 1 == "X") && (arr !! 2 == " "))
                                                                                                                            then do
                                                                                                                                imprimir (replaceNth 2 "O" arr)
                                                                                                                                jogo4 (replaceNth 2 "O" arr) (jogada+1) 1
                                                                                                                        else
                                                                                                                            if ((arr !! 2 == "X") && (arr !! 1 == "X") && (arr !! 0 == " "))
                                                                                                                                then do
                                                                                                                                    imprimir (replaceNth 0 "O" arr)
                                                                                                                                    jogo4 (replaceNth 0 "O" arr) (jogada+1) 1
                                                                                                                            -- |verifica a primeira coluna
                                                                                                                            else
                                                                                                                                if ((arr !! 0 == "X") && (arr !! 6 == "X") && (arr !! 3 == " "))
                                                                                                                                    then do
                                                                                                                                        imprimir (replaceNth 3 "O" arr)
                                                                                                                                        jogo4 (replaceNth 3 "O" arr) (jogada+1) 1
                                                                                                                                else
                                                                                                                                    if ((arr !! 0 == "X") && (arr !! 3 == "X") && (arr !! 6 == " "))
                                                                                                                                        then do
                                                                                                                                            imprimir (replaceNth 6 "O" arr)
                                                                                                                                            jogo4 (replaceNth 6 "O" arr) (jogada+1) 1
                                                                                                                                    else
                                                                                                                                        if ((arr !! 3 == "X") && (arr !! 6 == "X") && (arr !! 0 == " "))
                                                                                                                                            then do
                                                                                                                                                imprimir (replaceNth 0 "O" arr)
                                                                                                                                                jogo4 (replaceNth 0 "O" arr) (jogada+1) 1
                                                                                                                                        -- |verifica a terceira linha
                                                                                                                                        else
                                                                                                                                            if ((arr !! 6 == "X") && (arr !! 8 == "X") && (arr !! 7 == " "))
                                                                                                                                                then do
                                                                                                                                                    imprimir (replaceNth 7 "O" arr)
                                                                                                                                                    jogo4 (replaceNth 7 "O" arr) (jogada+1) 1
                                                                                                                                            else
                                                                                                                                                if ((arr !! 6 == "X") && (arr !! 7 == "X") && (arr !! 8 == " "))
                                                                                                                                                    then do
                                                                                                                                                        imprimir (replaceNth 8 "O" arr)
                                                                                                                                                        jogo4 (replaceNth 8 "O" arr) (jogada+1) 1
                                                                                                                                                        else
                                                                                                                                                            if ((arr !! 7 == "X") && (arr !! 8 == "X") && (arr !! 6 == " "))
                                                                                                                                                                then do
                                                                                                                                                                    imprimir (replaceNth 6 "O" arr)
                                                                                                                                                                    jogo4 (replaceNth 6 "O" arr) (jogada+1) 1
                                                                                                                                                            -- |verifica terceira coluna
                                                                                                                                                            else
                                                                                                                                                                if ((arr !! 8 == "X") && (arr !! 2 == "X") && (arr !! 5 == " "))
                                                                                                                                                                    then do
                                                                                                                                                                        imprimir (replaceNth 5 "O" arr)
                                                                                                                                                                        jogo4 (replaceNth 5 "O" arr) (jogada+1) 1
                                                                                                                                                                else
                                                                                                                                                                    if ((arr !! 8 == "X") && (arr !! 5 == "X") && (arr !! 2 == " "))
                                                                                                                                                                        then do
                                                                                                                                                                            imprimir (replaceNth 2 "O" arr)
                                                                                                                                                                            jogo4 (replaceNth 2 "O" arr) (jogada+1) 1
                                                                                                                                                                    else
                                                                                                                                                                        if ((arr !! 5 == "X") && (arr !! 2 == "X") && (arr !! 8 == " "))
                                                                                                                                                                            then do
                                                                                                                                                                                imprimir (replaceNth 8 "O" arr)
                                                                                                                                                                                jogo4 (replaceNth 8 "O" arr) (jogada+1) 1
                                                                                                                                                                        -- |verifica segunda coluna
                                                                                                                                                                        else
                                                                                                                                                                            if ((arr !! 1 == "X") && (arr !! 7 == "X") && (arr !! 4 == " "))
                                                                                                                                                                                then do
                                                                                                                                                                                    imprimir (replaceNth 4 "O" arr)
                                                                                                                                                                                    jogo4 (replaceNth 4 "O" arr) (jogada+1) 1
                                                                                                                                                                            else
                                                                                                                                                                                if ((arr !! 1 == "X") && (arr !! 4 == "X") && (arr !! 7 == " "))
                                                                                                                                                                                    then do
                                                                                                                                                                                        imprimir (replaceNth 7 "O" arr)
                                                                                                                                                                                        jogo4 (replaceNth 7 "O" arr) (jogada+1) 1
                                                                                                                                                                                -- |verifica segunda linha
                                                                                                                                                                                else
                                                                                                                                                                                    if ((arr !! 4 == "X") && (arr !! 5 == "X") && (arr !! 3 == " "))
                                                                                                                                                                                        then do
                                                                                                                                                                                            imprimir (replaceNth 3 "O" arr)
                                                                                                                                                                                            jogo4 (replaceNth 3 "O" arr) (jogada+1) 1
                                                                                                                                                                                    else
                                                                                                                                                                                        if ((arr !! 3 == "X") && (arr !! 5 == "X") && (arr !! 4 == " "))
                                                                                                                                                                                            then do
                                                                                                                                                                                                imprimir (replaceNth 4 "O" arr)
                                                                                                                                                                                                jogo4 (replaceNth 4 "O" arr) (jogada+1) 1
                                                                                                                                                                                        -- |verifica diagonais
                                                                                                                                                                                        else
                                                                                                                                                                                            if ((arr !! 3 == "X") && (arr !! 4 == "X") && (arr !! 5 == " "))
                                                                                                                                                                                                then do
                                                                                                                                                                                                    imprimir (replaceNth 5 "O" arr)
                                                                                                                                                                                                    jogo4 (replaceNth 5 "O" arr) (jogada+1) 1
                                                                                                                                                                                            -- |verifica diagonais
                                                                                                                                                                                            else
                                                                                                                                                                                                if ((arr !! 0 == "X") && (arr !! 4 == "X") && (arr !! 8 == " "))
                                                                                                                                                                                                    then do
                                                                                                                                                                                                        imprimir (replaceNth 8 "O" arr)
                                                                                                                                                                                                        jogo4 (replaceNth 8 "O" arr) (jogada+1) 1
                                                                                                                                                                                                else
                                                                                                                                                                                                    if ((arr !! 4 == "X") && (arr !! 8 == "X") && (arr !! 0 == " "))
                                                                                                                                                                                                        then do
                                                                                                                                                                                                            imprimir (replaceNth 0 "O" arr)
                                                                                                                                                                                                            jogo4 (replaceNth 0 "O" arr) (jogada+1) 1
                                                                                                                                                                                                    else
                                                                                                                                                                                                        if ((arr !! 2 == "X") && (arr !! 6 == "X") && (arr !! 4 == " "))
                                                                                                                                                                                                            then do
                                                                                                                                                                                                                imprimir (replaceNth 4 "O" arr)
                                                                                                                                                                                                                jogo4 (replaceNth 4 "O" arr) (jogada+1) 1
                                                                                                                                                                                                        else
                                                                                                                                                                                                            if ((arr !! 2 == "X") && (arr !! 4 == "X") && (arr !! 6 == " "))
                                                                                                                                                                                                                then do
                                                                                                                                                                                                                    imprimir (replaceNth 6 "O" arr)
                                                                                                                                                                                                                    jogo4 (replaceNth 6 "O" arr) (jogada+1) 1
                                                                                                                                                                                                            else
                                                                                                                                                                                                                if ((arr !! 6 == "X") && (arr !! 4 == "X") && (arr !! 2 == " "))
                                                                                                                                                                                                                    then do
                                                                                                                                                                                                                        imprimir (replaceNth 2 "O" arr)
                                                                                                                                                                                                                        jogo4 (replaceNth 2 "O" arr) (jogada+1) 1
                                                                                                                                                                                                                else
                                                                                                                                                                                                                    -- |se for a terceira jogada
                                                                                                                                                                                                                    if (jogada == 3)
                                                                                                                                                                                                                        -- |verifica a situação em que o usuário escolheu inicialmente canto e a máquina centro (qualquer posição na ponta deve estar ocupada e nenhum )
                                                                                                                                                                                                                        -- |se a posição central for "O" AND qualquer posição diagonal seja diferente de vazio AND todas posição no canto esteja vazia
                                                                                                                                                                                                                        then if ((arr !! 4 == "O") && ((arr !! 0 /= " ") || (arr !! 2 /= " ") || (arr !! 6 /= " ") || (arr !! 8 /= " ")) && ((arr !! 1 == " ") && (arr !! 5 == " ") && (arr !! 7 == " ") && (arr !! 3 == " ")))
                                                                                                                                                                                                                        -- |caso a situação anterior se satisfaça, a máquina deverá escolher qualquer posição no canto
                                                                                                                                                                                                                            then do
                                                                                                                                                                                                                                -- verifica se o usuário escolheu qualquer ponta oposta, como 0 e 8 ou 2 e 6 e escreve em qualquer canto
                                                                                                                                                                                                                                if (arr !! 0 == "X" && arr !! 8 == "X")
                                                                                                                                                                                                                                    then do
                                                                                                                                                                                                                                        imprimir (replaceNth 3 "O" arr)
                                                                                                                                                                                                                                        jogo4 (replaceNth 3 "O" arr) (jogada+1) 1
                                                                                                                                                                                                                                -- |se chegar a este ponto, e não for 0 e 8, então obviamente 2 e 6 estão ocupadas
                                                                                                                                                                                                                                else do
                                                                                                                                                                                                                                    imprimir (replaceNth 3 "O" arr)
                                                                                                                                                                                                                                    jogo4 (replaceNth 3 "O" arr) (jogada+1) 1
                                                                                                                                                                                                                            -- |do contrário, verifica se a posição central é "X" e se a máquina escreveu em 0, neste caso, escreve em 3
                                                                                                                                                                                                                            else if ((arr !! 4 == "X") && (arr !! 0 == "O"))
                                                                                                                                                                                                                                then do
                                                                                                                                                                                                                                    imprimir (firstEmpty 2 "O" arr)
                                                                                                                                                                                                                                    jogo4 (firstEmpty 2 "O" arr) (jogada+1) 1
                                                                                                                                                                                                                            -- |do contrário escreve em qualquer posição
                                                                                                                                                                                                                            else do
                                                                                                                                                                                                                                imprimir (firstEmpty 0 "O" arr)
                                                                                                                                                                                                                                jogo4 (firstEmpty 0 "O" arr) (jogada+1) 1
                                                                                                                                                                                                                    -- |do contrário escreve em qualquer posição
                                                                                                                                                                                                                    else do
                                                                                                                                                                                                                        imprimir (firstEmpty 0 "O" arr)
                                                                                                                                                                                                                        jogo4 (firstEmpty 0 "O" arr) (jogada+1) 1


-- |Jogo Principal
jogoPrincipal arr jogada jogador = do
    menu
    -- |lê e converte para inteiro
    opt <- readLn :: IO Int
    case opt of
        1 -> jogo1 arr jogada jogador
        2 -> jogo2 arr jogada jogador 0
        3 -> jogo3 arr jogada jogador 0
        4 -> jogo4 arr jogada jogador
        5 -> putStrLn "Obrigado por jogar :D"
    
main = do
    -- |Vetor inicial
    let arr = [" "," "," "," "," "," "," "," "," "]
    -- |Variáveis iniciais
    let jogada = 0
    let jogador = 1
    -- |Jogo Principal
    jogoPrincipal arr jogada jogador