data Turista = UnTurista {
    nivelDeCansancio :: Int, 
    nivelDeStress :: Int, 
    viajeSolo :: Bool,
    idiomas :: [String]
} deriving (Eq, Show)

type Excursion = Turista -> Turista
modificarNivelDeCansancio :: (Int -> Int ) -> Excursion
modificarNivelDeCansancio unaFuncion unTurista = unTurista { nivelDeCansancio = (max 0).unaFuncion.nivelDeCansancio $ unTurista }

modificarNivelDeStress :: (Int ->Int)-> Excursion
modificarNivelDeStress unaFuncion  unTurista = unTurista { nivelDeStress = (max 0).unaFuncion.nivelDeStress $ unTurista}

modificarViajeSola :: Bool-> Excursion
modificarViajeSola unBool unTurista = unTurista { viajeSolo = unBool }

modificarIdioma :: String -> Excursion
modificarIdioma nuevoIdioma unTurista = unTurista { idiomas = (++ [nuevoIdioma]).idiomas $ unTurista}


viajeSola :: Excursion
viajeSola unTurista | viajeSolo unTurista = modificarNivelDeCansancio (const 5) $ unTurista
                    | otherwise = modificarNivelDeStress (const 1) $ unTurista

apreciarElementoDelPaisaje :: String -> Excursion
apreciarElementoDelPaisaje unElemento unTurista = modificarNivelDeStress (+ (length unElemento))  unTurista

salirAHablarUnIdioma :: String -> Excursion
salirAHablarUnIdioma nuevoIdioma unTurista = (modificarIdioma nuevoIdioma).(modificarViajeSola True) $ unTurista

caminar :: Int  -> Excursion
caminar intensidad unTurista = (modificarNivelDeCansancio  (dividirYRestar intensidad)) .(modificarNivelDeStress (dividirYRestar intensidad)) $ unTurista

dividirYRestar :: Int -> (Int -> Int )
dividirYRestar unNumero = flip (-) ( div unNumero 4) 


paseoEnBarco :: String -> Excursion
paseoEnBarco "Fuerte" unTurista = (modificarNivelDeCansancio (flip (-) 10)).(modificarNivelDeStress (flip (-) 6))  $ unTurista
paseoEnBarco "Tranquila"  unTurista = (caminar 10 ).(apreciarElementoDelPaisaje "mar ").(salirAHablarUnIdioma "aleman") $ unTurista
paseoEnBarco "Moderada" unTurista = unTurista

ana ::  Turista
ana = UnTurista { nivelDeCansancio = 0 , nivelDeStress = 21 , viajeSolo = False, idiomas = ["espaniol"]}

beto :: Turista
beto = UnTurista { nivelDeCansancio = 15, nivelDeStress = 15 , viajeSolo = True , idiomas = ["aleman"]}

cathi :: Turista
cathi = modificarIdioma "catalan" beto



hacerExcursion :: Turista -> Excursion -> Turista
hacerExcursion unTurista unaExcursion = (modificarNivelDeStress (* (div 10 100))).unaExcursion $ unTurista


