import Text.Show.Functions

data Barbaro = Unbarbaro {
    nombre :: Nombre,
    fuerza :: Fuerza,
    habilidades :: Habilidades,
    objetos :: [Objeto]
} deriving Show

type Nombre = String 
type Fuerza = Int 
type Habilidades = [String]
type Objeto = Barbaro -> Barbaro 
type Objetos = [Objeto]


dave :: Barbaro 
dave = Unbarbaro {
    nombre = "Dave",
    fuerza = 100, 
    habilidades = ["tejer", " escribirpoesia"],
    objetos = [ ardilla ]
}


pepe :: Barbaro 
pepe = Unbarbaro { nombre = "PEPE",
  fuerza = 150,
  habilidades = ["Escribir poesia atroz"],
  objetos = [ardilla]}


espadas :: Int -> Objeto
espadas unPeso unBarbaro = unBarbaro {fuerza = (2 * unPeso) + (fuerza  unBarbaro)}

ardilla :: Objeto 
ardilla unBarbaro = unBarbaro

amuletosMisticos ::  Objeto 
amuletosMisticos unBarbaro = unBarbaro {habilidades = (habilidades unBarbaro ) ++ ["Hacer magia "], 
             objetos = []}

cuerda :: Objeto -> Objeto -> Objeto 
cuerda unObjeto otroObjeto =  unObjeto.otroObjeto


------------------------ punto 2  ---------------------------

--megafono :: Objeto
--megafono unBarbaro = concat.ponerEnMayusculaUnaPalabra $ habilidades unBarbaro

--ponerEnMayusculaUnaPalabra :: Habilidades -> Habilidades 
--ponerEnMayusculaUnaPalabra unasHabilidades = map (map toUpper) unasHabilidades





------------------------- punto 3 

invasionesDeSuciosDuendes :: Barbaro -> Bool 
invasionesDeSuciosDuendes unBarbaro = tieneHabilidad "Escribir poesia atroz" unBarbaro

tieneHabilidad :: String -> Barbaro -> Bool
tieneHabilidad unaHabilidad unBarbaro = elem unaHabilidad.habilidades $ unBarbaro


cremalleraDelTiempo :: Barbaro -> Bool
cremalleraDelTiempo unBarbaro = noTienePulgares.nombre $ unBarbaro

noTienePulgares :: Nombre -> Bool
noTienePulgares "Faffy" = True
noTienePulgares "Astro" = True
noTienePulgares _ = False

saqueo :: Barbaro -> Bool 
saqueo unBarbaro = tieneHabilidad " Robar " unBarbaro && fuerzaMayorA 80 unBarbaro

fuerzaMayorA :: Fuerza -> Barbaro -> Bool
fuerzaMayorA unaFuerza unBarbaro = (> unaFuerza ).fuerza $ unBarbaro

gritoDeGuerra :: Barbaro -> Bool 
gritoDeGuerra unBarbaro =  (== cantidadDeLetrasHabilidades unBarbaro).poderDeGrito $ unBarbaro


poderDeGrito :: Barbaro -> Int 
poderDeGrito unBarbaro = (* 4).length.objetos $ unBarbaro

cantidadDeLetrasHabilidades :: Barbaro -> Int 
cantidadDeLetrasHabilidades unBarbaro = sum.(map length).habilidades $ unBarbaro


caligrafia :: Barbaro -> Bool 
caligrafia unBarbaro = habilidadesConTresVocales unBarbaro && habilidadesConMayuscula unBarbaro

habilidadesConTresVocales :: Barbaro -> Bool
habilidadesConTresVocales unBarbaro = all tieneMasDeTresVocales (habilidades unBarbaro)

tieneMasDeTresVocales :: String -> Bool 
tieneMasDeTresVocales unaHabilidad = (>3).length.filter esVocal $ unaHabilidad

esVocal :: Char -> Bool 
esVocal unaLetra = elem unaLetra "AEIOUaeiou"


habilidadesConMayuscula :: Barbaro -> Bool 
habilidadesConMayuscula unBarbaro = all (esMayuscula.head) (habilidades  unBarbaro)

esMayuscula :: Char -> Bool 
esMayuscula unaLetra = elem unaLetra "ASDFGHJKLPOIUYTREWQZXCVBNM"


----------------------------- punto 4 

sinRepetidos :: (Eq a ) => [a] -> [a]
sinRepetidos [] =[] 
sinRepetidos (x:xs) | elem x xs = sinRepetidos xs
                    | otherwise = ([x]++).sinRepetidos $ xs





