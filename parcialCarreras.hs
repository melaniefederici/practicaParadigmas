----------------------------
-- Punto 1
----------------------------
data Auto = Auto {
    color :: String,
    velocidad :: Int,
    distanciaRecorrida :: Int
} deriving (Show)

type Carrera = [Auto]

estaCerca :: Auto -> Auto -> Bool
estaCerca unAuto otroAuto = if unAuto != otroAuto && distanciaEntreAutos unAuto 

distanciaEntreAutos :: Carrera -> Int
distanciaEntreAutos unAuto otroAuto 
    | 

----------------------------
-- Punto 2
----------------------------
