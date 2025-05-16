module Library where
import PdePreludat
-- import qualified Data.List as sum

-- Ventajas de la evaluacion diferida
-- 1. Permite la definicion de funciones recursivas
-- 2. Permite la definicion de funciones infinitas
-- 3. Permite la definicion de funciones que no terminan
-- 4. Permite la definicion de funciones que no son computables
-- 5. Permite la definicion de funciones que no son decidibles

-- divisor nos dice si un numero es divisor de otro
-- ej. divisor 2 4 == True
divisor::Number->Number->Bool
divisor unNumero otroNumero = otroNumero `mod` unNumero == 0

-- noHayDivisores nos dice si un numero no tiene divisores entre dos numeros
-- ej. noHayDivisores 2 3 5 == True
noHayDivisores::Number->Number->Number->Bool
noHayDivisores unNumero minimo maximo
  | divisor minimo unNumero = False
  | minimo == maximo = True
  | otherwise = noHayDivisores unNumero (minimo+1) maximo

-- esPrimo nos dice si un numero es primo
-- ej. esPrimo 2 == True
esPrimo::Number->Bool
esPrimo 1 = False
esPrimo 2 = True
esPrimo n = noHayDivisores n 2 (n-1)

data Cliente = Cliente {
  nombre::String,
  deuda::Number,
  facturas::[Number]
} deriving (Show, Eq)

-- funcion clienteQueDeben mayor a un monto
clientesQueDeben :: Number -> [Cliente] -> [Cliente]
clientesQueDeben _ [] = []
clientesQueDeben monto (cliente:clientes)
  | ((>monto).deuda) cliente = cliente:clientesQueDeben monto clientes
  | otherwise = clientesQueDeben monto clientes

palindromo nombre = nombre == reverse nombre

-- clientesPalindromos devuelve una lista de clientes cuyos nombres son palindromos
clientesPalindromos::[Cliente]->[Cliente]
clientesPalindromos [] = []
clientesPalindromos (cliente:clientes)
  | (palindromo.nombre) cliente = cliente:clientesPalindromos clientes
  | otherwise =clientesPalindromos clientes

-- funcion clientesConFacturaDe devuelve una lista de clientes con facturas de un determinado monto 
clientesConFacturaDe :: Number -> [Cliente] -> [Cliente]
clientesConFacturaDe _ [] = []
clientesConFacturaDe monto (cliente:clientes)
  | (elem monto.facturas) cliente = cliente:clientesConFacturaDe monto clientes
  | otherwise = clientesConFacturaDe monto clientes

--Funciones de orden superior


-- funcion filter' es una funcion de orden superior que filtra una lista
-- ej. filter' (>2) [1,2,3,4] == [3,4]
filter' :: (a -> Bool) -> [a] -> [a]
filter' _ [] = []
filter' f (x:xs)
  | f x = x : filter' f xs
  | otherwise = filter' f xs

-- clientesQueDeben' es una funcion que filtra una lista de clientes
-- ej. clientesQueDeben' 100 [Cliente "Juan" 200 [], Cliente "Pedro" 50 []] == [Cliente "Juan" 200 []]
clientesQueDeben' :: Number -> [Cliente] -> [Cliente]
clientesQueDeben' monto = filter' ((>monto).deuda)


-- clientesPalindromos' es una funcion que filtra una lista de clientes
-- ej. clientesPalindromos' [Cliente "Juan" 200 [], Cliente "Pedro" 50 []] == []
clientesPalindromos' :: [Cliente] -> [Cliente]
clientesPalindromos' = filter' (palindromo.nombre)

-- clientesConFacturasDe' es una funcion que filtra una lista de clientes con facturas de un determinado monto
-- ej. clientesConFacturasDe' 100 [Cliente "Juan" 200 [100], Cliente "Pedro" 50 []] == [Cliente "Juan" 200 [100]]
clientesConFacturasDe' :: Number -> [Cliente] -> [Cliente]
clientesConFacturasDe' monto = filter' (elem monto.facturas)

-- Importante: Orden superior es la puerta de entrada para poder abstraer codigo
-- filter de [a] debe recibir un parametro f que sea una funcion de tipo a -> Bool
-- las funciones de orden superior recibe funciones de orden simple como parametros
-- y devuelve funciones de orden simple como resultado

-- funcion map es una funcion de orden superior que aplica una funcion a cada elemento de una lista
-- ej. map (*2) [1..3] == [2,4,6]
-- map length ["Hola", "Mundo"] == [4,5]
-- map desgasteTotal autos
--      where desgasteTotal auto = desgasteChasis auto + desgasteRuedas auto
map' :: (a -> b) -> [a] -> [b]
map' _ [] = []
map' f (x:xs) = f x : map' f xs

-- funcion all' es una funcion de orden superior que devuelve True si todos los elementos de una lista cumplen con una condicion
-- ej. all' (>2) [3,4,5] == True
-- all' (>2) [1,2,3] == False
all' :: (a -> Bool) -> [a] -> Bool
--all' condicion lista = (and.map condicion) lista
all' condicion = and.map condicion

{-
all' :: (a -> Bool) -> [a] -> Bool
all' _ [] = True
all' f (x:xs)
  | f x = all' f xs
  | otherwise = False
-}

-- sumOf es una funcion que dado una lista de elementos y una funcion que devuelve la suma de los numeros 
sumOf :: (a -> Number) -> [a] -> Number
sumOf f xs = (sum.map f) xs

-- funcion flip es una funcion de orden superior que invierte el orden de los parametros de una funcion
flip' :: (a -> b -> c) -> b -> a -> c
flip' f x y = f y x

--el prelode viene con foldl1, foldr1, foldl, foldr. Son operaciones abiertas
-- foldl1 max [4,2,7]
-- foldl1 (+) [4,2,7]
-- fold1 trabaja con funciones binarias cerradas y la lista debe tener al menos un elemento



--foldl1' (a->a->a)->[a]->a
--foldl1' _ [] = error "foldl1: empty list"
--foldl1' f (x:xs) = foldl f x xs

-- foldr ((+).length) 0 ["Hola", "Mundo"]
-- foldr ((+).length) 0 ["Hola", "Mundo"] == 9

-- foldl' es una funcion de orden superior que aplica una funcion a cada elemento de una lista de izquierda a derecha
-- ej. foldr' (+) 0 [1,2,3] == 6
-- ej. foldr' ((&&).(<5)) True [1..] == False   
-- Importante: se le puede pasar una lista infinita en algunos casos, pero usa mas stack
foldr' :: (a -> b -> b) -> b -> [a] -> b
foldr' _ semilla [] = semilla
foldr' f semilla (x:xs) = f x (foldr' f semilla xs)

-- foldl' es una funcion de orden superior que aplica una funcion a cada elemento de una lista de derecha a izquierda
-- ej. foldl' (+) 0 [1,2,3] == 6
foldl' :: (b -> a -> b) -> b -> [a] -> b
foldl' _ semilla [] = semilla
foldl' f semilla (x:xs) = foldl' f (f semilla x) xs

-- funcion de aplicacion 
--($) :: (a -> b) -> a -> b
--f $ x = f x
-- ej. ($) (take 1) [1..] == [1]


-- ej. take 1 $ [1..] == [1]
-- ej. (take 1.filter even) [1..10] == [2]

-- ejemplo de aplicacion de foldr
data Persona = Persona {
  edad::Number,
  felicidad::Number,
  amigos::[String]
} deriving (Show, Eq)

cumplirAnios :: Persona -> Persona
cumplirAnios persona = persona {edad = edad persona + 1, felicidad = felicidad persona + 1}
caminar :: Number -> Persona -> Persona
caminar cantidad persona = persona {felicidad = felicidad persona + cantidad}
hacerAmiwi:: String-> Persona -> Persona
hacerAmiwi nombre persona = persona {amigos = amigos persona ++ [nombre]}
-- foldr ($) juan [cumplirAnios, caminar 3, hacerAmiwi "Juanito"]
-- foldr funcion semilla lista

