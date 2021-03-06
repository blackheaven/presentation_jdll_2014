--------------
ajoute a b = a + b
-- :l exemple.hs
-- :t ajoute
-- ajoute 1 3
-- ajoute 1.0 4.0
-- ajoute 'a' 'b'

-------------
ajoute :: Num a => a -> a -> a -- si je remet la signature inféré
ajoute a b = a + b
-- :r
-- :t ajoute -- rien ne change

-------------
ajoute :: Int -> Int -> Int -- si je spécialise ma fonction
ajoute a b = a + b
-- :r
-- :t ajoute
-- ajoute 1 3
-- ajoute 1.0 4.0

-------------
ajoute :: Int -> Int -> Char -- si je me trompe
ajoute a b = a + b
-- :r -- ça ne compilera pas, il ne peut compiler que s'il peut prouver
-- qu'il n'y aura pas d'erreur de types

-------------
ajoute :: a -> a -> a -- si je ne met pas assez de contraintes
ajoute a b = a + b
-- :r -- ça ne compilera pas non plus

--------------
const' :: -- je veux une fonction qui prennent deux paramères et qui me retourne le premier
-- je veux que : const' 1 'a' = 1
const' :: a -> b -> a
const' x y = -- les noms des paramètres sont décorellés de leur type
const' x y = x
-- :r
-- const' 1 'a'
-- laissons les fonctions de côté, 30s, passons aux types

----------------
data Es = Es Int deriving (Show) -- ElementStore
-- :r
-- Es 42
-- :t Es 42

----------------
data Es = Es Int deriving (Show) -- ElementStore
get :: Es -> Int -- on veut récupérer sa valeur
get (Es x) = x
-- :r
-- get (Es 42)
-- get (Es 2)
-- :t Es 42

----------------
data Es = El Int | Null deriving (Show) -- peut être nul
-- get :: Es -> Int -- on veut récupérer sa valeur
-- get (Es x) = x
-- :r
-- El 42
-- Null
-- :t El 42
-- :t Null
-- Equivalent à Maybe :
-- Just 1
-- Nothing
-- :t Just 1
-- :t Nothing
-- plus de segfault ou de NPE !

----------------
data Es = El Int | Null deriving (Show) -- peut être nul
get :: Int -> Es -> Int -- on ajoute une valeur par défault
get x Null = x -- toujours commencer par le cas le moins général
get _ (El x) = x
-- :r
-- get 1 Null
-- get 1 (El 2)

----------------
data Es = El Int Es | Null deriving (Show) -- on a une liste !
-- get :: Int -> Es -> Int -- on ajoute une valeur par défault
-- get x Null = x -- toujours commencer par le cas le moins général
-- get _ (El x) = x
-- :r
-- El 42 Null
-- El 42 (El 2 Null)
-- Null
-- :t El 42 Null
-- :t El 42 (El 2 Null)
-- :t Null
-- Equivalent à :
-- 42:[]
-- 42:2:[]
-- []
-- ou
-- [42, 2]

-----------------
head' :: [Int] -> Int
head' -- quoi ?
head' [x] = x -- bug pour head [1, 2]
head' (x:_) = x
-- :r
-- head' [1]
-- head' [1, 2]
-- head' []

------------------
sum' :: [Int] -> Int
sum' s = sum'' s 0
    where sum'' [] acc = acc
          sum'' (x:xs) acc = sum'' xs (acc + x)

prod' :: [Int] -> Int
prod' s = prod'' s 0
    where prod'' [] acc = acc
          prod'' (x:xs) acc = prod'' xs (acc * x)

-------------------
fold' _ acc [] = acc -- :t
fold' op acc (x:xs) = fold' op (op acc x) xs

sum' :: [Int] -> Int
sum' s = fold' (+) 0 s

prod' :: [Int] -> Int
prod' s = fold' (*) 1 s

-------------------
fold' _ acc [] = acc
fold' op acc (x:xs) = fold' op (op acc x) xs

const2 _ x = x
last' s = fold' const2 0 s
