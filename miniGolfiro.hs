-- Modelo inicial
data Jugador = UnJugador {
  nombre :: String,
  padre :: String,
  habilidad :: Habilidad
} deriving (Eq, Show)

data Habilidad = Habilidad {
  fuerzaJugador :: Int,
  precisionJugador :: Int
} deriving (Show,Eq)

bart :: Jugador
bart = UnJugador "Bart" "Homero" (Habilidad 25 60)

todd :: Jugador
todd = UnJugador "Todd" "Ned" (Habilidad 15 80)

rafa :: Jugador
rafa = UnJugador "Rafa" "Gorgory" (Habilidad 10 1)

data Tiro = UnTiro {
  velocidad :: Int,
  precision :: Int,
  altura :: Int
} deriving (Eq, Show)

type Puntos = Int

-- Funciones útiles
between n m x = elem x [n .. m]

maximoSegun f = foldl1 (mayorSegun f)
mayorSegun f a b
  | f a > f b = a
  | otherwise = b


type Palos = Tiro -> Tiro 

------------------- Modificadores de Tiro ------------------------------

modificarVelocidad :: (Int -> Int) ->  Tiro -> Tiro 
modificarVelocidad  unaFuncion unTiro = unTiro { velocidad = unaFuncion.velocidad $ unTiro}

modificarPrecision :: (Int ->Int  )-> Tiro -> Tiro 
modificarPrecision unaFuncion  unTiro = unTiro { precision = unaFuncion.precision $ unTiro}

modificarAltura :: Int -> Tiro -> Tiro 
modificarAltura unNumero unTiro = unTiro { altura = unNumero}


------------------------  Palos 
putter :: Palos
putter unTiro = modificarTiro 0 (* 2) (const 10) unTiro
   

madera :: Palos 
madera unTiro =  modificarTiro 5 (flip div 2) (const 100 ) unTiro
   

hierros :: Int ->Palos
hierros unNumero unTiro = modificarTiro (max 0 (unNumero - 3)) (* unNumero ) (flip div 2) unTiro
   

listaDePalos :: [Palos]
listaDePalos = [putter , madera , hierros 1 , hierros 2 , hierros 3 , hierros 4 , hierros 5 , hierros 7, hierros 6 , hierros 8, hierros 9 , hierros 10  ]

golpe :: Jugador -> Palos  -> Tiro
golpe unJugador unPalo = unPalo.crearTiroJugador $ unJugador


crearTiroJugador :: Jugador -> Tiro
crearTiroJugador unJugador = UnTiro {velocidad = (fuerzaJugador.habilidad $ unJugador), altura = 0 , precision = (precisionJugador.habilidad $ unJugador)}


-------------- obstaculos 

modificarTiro :: Int -> (Int -> Int ) -> (Int -> Int ) -> Tiro ->Tiro 
modificarTiro newAltura newPrecision newVelocidad unTiro =(modificarAltura newAltura).(modificarPrecision newPrecision).(modificarVelocidad newVelocidad) $ unTiro


type Obstaculos = Tiro -> Tiro
tunelConRampita :: Obstaculos
tunelConRampita unTiro | superaRampa (>90) (precision unTiro) (== 0) (altura unTiro) = modificarTiro 0 (const 100 ) (* 2) unTiro
                       | otherwise = modificarTiro 0 (const 0 ) (const 0 ) unTiro
                       
 
superaRampa :: (Int -> Bool)-> Int -> (Int -> Bool) -> Int  -> Bool 
superaRampa unaFuncion unNumero otraFuncion otroNumero = mayorOIgualA unaFuncion unNumero && mayorOIgualA otraFuncion otroNumero

mayorOIgualA :: (Int -> Bool) -> Int -> Bool
mayorOIgualA unaFuncion unNumero = unaFuncion unNumero

laguna :: Int -> Obstaculos
laguna largo unTiro | superaRampa (>80) (velocidad unTiro) (between 1 5) (altura unTiro) = modificarTiro (flip div largo(altura unTiro)) (const (precision unTiro)) (const (velocidad unTiro)) unTiro
                    | otherwise = modificarTiro 0 (const 0 ) (const 0 ) unTiro


hoyo :: Obstaculos 
hoyo unTiro | superaRampa (>95) (precision unTiro) (between 5 20) (velocidad unTiro) && mayorOIgualA (==0) (altura unTiro) = modificarTiro 0 (const 0 ) (const 0 ) unTiro
            | otherwise = unTiro


-------------------- palos utilies 

palosUtiles :: Jugador -> Obstaculos -> [Bool]
palosUtiles unJugador unObstaculo  = map ((/= (UnTiro 0 0 0) ).unObstaculo.(golpe unJugador))  listaDePalos


listaPalosYObastaculos :: Jugador -> Obstaculos -> [Palos] -> [Tiro]
listaPalosYObastaculos unJugador unObstaculo unaLista = map (unObstaculo.(golpe unJugador)) unaLista