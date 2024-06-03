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


