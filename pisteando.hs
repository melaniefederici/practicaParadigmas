------------------------------------ Punto 1 ------------------------------------
data Auto = Auto {
    marca :: String,
    modelo :: String,
    desgaste :: (Float, Float),    --chasis ruedas
    velocidadMaxima :: Float,
    tiempo :: Float
} deriving (Show)

-- a --
ferrari = Auto "Ferrari" "F50" (0,0) 65 0

-- b --
famborghini = Auto "Lamborghini" "Diablo" (7,4) 73 0

-- c --
fiat = Auto "Fiat" "600" (33,27) 44 0


------------------------------------ Punto 2 ------------------------------------
-- a --
estaEnBuenEstado :: Auto -> Bool
estaEnBuenEstado unAuto = (<40)(fst . desgaste $ unAuto) && (<100)(snd . desgaste $ unAuto )

-- b --
noDaMas :: Auto -> Bool
noDaMas unAuto = (>80)(fst . desgaste $ unAuto) || (>80)(snd . desgaste $ unAuto )


------------------------------------ Punto 3 ------------------------------------
repararUnAuto :: Auto -> Auto
repararUnAuto = cambiarDesgasteChasis (*0.15) . cambiarDesgasteRuedas (const 0)

cambiarDesgasteRuedas :: (Float -> Float) -> Auto -> Auto
cambiarDesgasteRuedas f unAuto = unAuto {desgaste = (fst . desgaste $ unAuto, f . snd . desgaste $ unAuto)}

cambiarDesgasteChasis :: (Float -> Float) -> Auto -> Auto
cambiarDesgasteChasis f unAuto = unAuto {desgaste = (f . fst . desgaste $ unAuto, snd . desgaste $ unAuto)}


------------------------------------ Punto 4 ------------------------------------
-- a --
type Tramo = Auto -> Auto

curva :: Float -> Float -> Tramo
curva unAngulo unaLongitud unAuto = cambiarDesgasteChasis (+ 3 * unaLongitud / unAngulo) . aumentarTiempo (unaLongitud / (velocidadMaxima unAuto) / 2) $ unAuto

aumentarTiempo :: Float -> Auto -> Auto
aumentarTiempo unosSegundos unAuto = unAuto {tiempo = tiempo unAuto + unosSegundos}


------ i
curvaPeligrosa :: Tramo
curvaPeligrosa = curva 60 300

------ ii
curvaTranca :: Tramo
curvaTranca = curva 110 550


-- b --
recta :: Float -> Tramo
recta unaLongitud unAuto = unAuto {
    desgaste = ((fst . desgaste $ unAuto) + unaLongitud / 100, snd . desgaste $ unAuto),
    tiempo = (tiempo unAuto) + unaLongitud / (velocidadMaxima unAuto)
}

------ i
tramoRectoClassic :: Tramo
tramoRectoClassic = recta 750

------ ii
tramito :: Tramo
tramito = recta 280


-- c --
boxes :: Tramo -> Tramo
boxes unTramo unAuto
    | estaEnBuenEstado unAuto = unTramo unAuto
    | otherwise = aumentarTiempo 10 . repararUnAuto $ unAuto



-- d --
mojada :: Tramo -> Tramo
mojada unTramo unAuto = aumentarTiempo segundosPorMojado . unTramo $ unAuto
    where
        segundosPorMojado = (tiempo (unTramo unAuto) - tiempo unAuto) / 2


-- e --
ripio :: Tramo -> Tramo
ripio unTramo = unTramo . unTramo


-- f --
obstruccion :: Tramo -> Float -> Tramo
obstruccion unTramo unaLongitud unAuto = cambiarDesgasteRuedas (+ (unaLongitud * 2)) . unTramo $ unAuto


------------------------------------ Punto 5 ------------------------------------
pasarPorTramo :: Auto -> Tramo -> Auto
pasarPorTramo unAuto unTramo
    | noDaMas unAuto = unAuto
    | otherwise = unTramo unAuto


------------------------------------ Punto 6 ------------------------------------
type Pista = [Tramo]

-- a --
superPista :: Pista
superPista = [
    tramoRectoClassic,
    curvaTranca,
    (tramito . mojada tramito),
    obstruccion (curva 80 400) 2,
    curva 115 650,
    recta 970,
    curvaPeligrosa,
    ripio tramito,
    boxes (recta 800)
    ]

-- b --
peganLaVuelta :: Pista -> [Auto] -> [Auto]
peganLaVuelta unaPista = filter (not . noDaMas) . map (pegaUnaVuelta unaPista)

pegaUnaVuelta :: Pista -> Auto -> Auto
pegaUnaVuelta unaPista unAutos = foldl pasarPorTramo unAutos unaPista


-- ------------------------------------ Punto 7 ------------------------------------
-- -- a --
data Carrera = Carrera {
    pista :: Pista,
    vueltas :: Int
}

-- b --
tourDeBuenosAires :: Carrera
tourDeBuenosAires = Carrera superPista 20

-- c --
jugarCarrera :: [Auto] -> Carrera -> [[Auto]]
jugarCarrera unosAutos unaCarrera = take (vueltas unaCarrera) . iterate (peganLaVuelta (pista unaCarrera)) $ unosAutos
