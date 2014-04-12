-- Valeures primitives
5
42
1.0
26.4
'a'
'D'

-- Opérateurs
1 + 2
4.0 + 5.5
'a' + 'b' -- Haskell est fortement typé

-- Voir le type
:t 1
:t 1.0
:t 'a'
:t (+) -- fonction qui prend une valeur, puis une autre du même type, puis il en retourne une troisième du même type // elle doivent être du genre Num

-- Dans fonctionnel il y a fonction
let id' a = a -- fonction la plus stupide que l'on peut écrire // le ' ne signifie rien
:t id' -- prend n'importe quel type
id' 1 -- notation préfixe car ce n'est pas un opérateur : il commence par une lettre
id' 'a'
:t id' 1 -- le type est bien respecté
:t id' 'a'

let ajoute a b = a + b
:t ajoute -- il a deviné le type : inférence de type // par défaut : plus général possible
ajoute 1 3

-- ouvrez un fichier
