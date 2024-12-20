-- Pto 1
data GuerreroZ = GuerreroZ {
    nombre :: String,
    ki :: Nivel,
    raza :: Raza,
    cansancio :: Nivel,
    personalidad :: Personalidad
} deriving(Show, Eq)

type Nivel = Double

data Raza = Humano | Namekiano | Saiyajin  deriving(Show, Eq)

gohan :: GuerreroZ
gohan = (GuerreroZ "Gohan" 10000 Saiyajin 0)


-- Pto 2
esPoderoso :: GuerreroZ -> Bool
esPoderoso = kiMayorA 8000 || esSaiyajin

kiMayorA :: Nivel -> GuerreroZ -> Bool
kiMayorA unNivel  = (> unNivel) . ki 

esSaiyajin :: GuerreroZ -> Bool
esSaiyajin = (== Saiyajin) . raza


-- Pto 3
type Ejercicio = GuerreroZ -> GuerreroZ

pressDeBanca :: Ejercicio
pressDeBanca = aumentarCansancio 100 . aumentarKi 90

aumentarCansancio :: Nivel -> GuerreroZ -> GuerreroZ
aumentarCansancio unNivel = (+ unNivel) . cansancio

aumentarKi :: Nivel -> GuerreroZ -> GuerreroZ
aumentarKi unNivel = (+ unNivel) . ki

flexionesDeBrazo :: Ejercicio
flexionesDeBrazo = aumentarCansancio 50

saltosAlCajon :: Double -> Ejercicio
saltosAlCajon altura = aumentarKi (altura/10) . aumentarCansancio (altura/5)

snatch :: Ejercicio
snatch unGuerrero 
    | esExperimentado unGuerrero = (aumentarKi (ki unGuerrero * 0.05) . aumentarCansancio (cansancio unGuerrero * 0.1)) unGuerrero
    | otherwise = (aumentarCansancio 100) unGuerrero

esExperimentado :: GuerreroZ -> Bool
esExperimentado = kiMayorA 22000

nivelDeCansansio :: Nivel -> GuerreroZ -> Bool
nivelDeCansansio unNivel unGuerrero = cansancio unGuerrero > ki unGuerrero * unNivel

estaCansado :: GuerreroZ -> Bool
estaCansado = nivelDeCansansio 0.44

estaExhausto :: GuerreroZ -> Bool
estaExhausto  = nivelDeCansansio 0.72

realizarEjercicio :: GuerreroZ -> Ejercicio -> GuerreroZ
realizarEjercicio unGuerrero unEjercicio =
    | estaCansado unGuerrero = hacerEjercicioCansado unGuerrero unEjercicio
    | estaExhausto unGuerrero = aumentarKi (ki unGuerrero * (-0.02))
    | otherwise = unEjercicio unGuerrero 

hacerEjercicioCansado :: GuerreroZ -> Ejercicio -> GuerreroZ
hacerEjercicioCansado unGuerrero unEjercicio = aumentarKi alDoble . aumentarCansancio alCuadruple $ unGuerrero
    where
        alDoble = multiplicadorSegunCriterio ki 2 unGuerrero unEjercicio
        alCuadruple = multiplicadorSegunCriterio cansancio 4 unGuerrero unEjercicio

multiplicadorSegunCriterio :: (GuerreroZ -> Nivel) -> Nivel -> GuerreroZ -> Ejercicio -> Double
multiplicadorSegunCriterio unCriterio unNivel unGuerrero unEjercicio =
    (unCriterio (unEjercicio unGuerrero) - criterio unGuerrero) * multiplicador


-- Pto 4
data Personalidad = Sacado | Perezoso | Tramposo deriving(Show, Eq)

type Rutina = [Ejercicio]

armarRutina :: GuerreroZ -> [Ejercicio] -> Rutina
armarRutina unGuerrero = rutinaPara (personalidad unGuerrero)

rutinaPara :: Personalidad -> [Ejercicio] -> Rutina
rutinaPara Sacado ejercicios = ejercicios
rutinaPara Perezoso ejercicios = map (descansar 5 .) ejercicios
rutinaPara Tramposo _ = []


-- Pto 5
realizarRutina :: GuerreroZ -> Rutina -> GuerreroZ
realizarRutina unGuerrero unaRutina = foldl (realizarEjercicio) unGuerrero unaRutina


--Pto 6
desacnsar :: Double -> GuerreroZ -> GuerreroZ
descansar unosMinutos = aumentarCansancio (- sum( [0..unosMinutos]))


-- Pto 7
descansoOptimo :: GuerreroZ -> Double
descansoOptimo unGuerrero = genericLegth . takeWhile (estaCansado . ($ guerrero) . descansar) $ [0..]