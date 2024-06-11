-- Punto 1: MODELAR A LOS HEROES --

type Tarea = Heroe -> Heroe

data Heroe = Heroe {
    epiteto :: Sring,
    reconocimiento :: Int,
    artefactos :: [Artefacto],
    tareas :: [Tarea]
}

data Artefacto = {
    nombre :: String,
    rareza :: Int
}



-- Punto 2: HEROE PASA A LA HISTORIA --

quePaseALaHistoria :: Tarea
quePaseALaHistoria unHeroe
    | reconocimiento >  1000 == cambiarEpiteto "El mitico" unHeroe
    | reconocimiento >= 500  == cambiarEpiteto "El magnifico" . agregarArtefacto "Lanza del Olimpo" $ unHeroe
    | reconocimiento >  100  == cambiarEpiteto "Hoplita" .agregarArtefacto "Xiphos" $ unHeroe
    | otherwise == unHeroe

--------
lanzaDelOlimpo :: Artefacto
lanzaDelOlimpo = Artefacto "Lanza del Olimpo" 100
xiphos :: Artefacto
xiphos = Artefacto "Xiphos" 50
--------

cambiarEpiteto :: Tarea
cambiarEpiteto unEpiteto unHeroe = unHeroe {epiteto = unEpiteto}

agregarArtefacto :: Artefacto -> Tarea
agregarArtefacto unArtefacto unHeroe = cambiarArtefactos (unArtefacto :)

cambiarArtefactos :: ([Artefacto] -> [Artefacto]) -> Heroe -> Heroe
cambiarArtefactos modificador unHeroe = unHeroe {artefactos = modificador (artefactos unHeroe)} 



-- Punto 3: MODELAR LAS TAREAS --

encontrarUnArtefacto :: Artefacto -> Tarea --------------
encontrarUnArtefacto unArtefacto = ganarReconocimiento (rareza unArtefacto) . agregarArtefacto unArtefacto

ganarReconocimiento :: Int -> Tarea
ganarReconocimiento cantidad unHeroe = unHeroe {reconocimiento = cantidad + reconocimiento unHeroe}

escalarElOlimpo :: Tarea ------------------
escalarElOlimpo = agregarArtefacto relampagoDeZeus . desechoArtefactos . triplicarRarezas . ganarReconocimiento 500

relampagoDeZeus :: Artefacto
relampagoDeZeus = Artefacto "El Relampago de Zeuz" 500

triplicarRarezas :: Tarea
triplicarRarezas = cambiarArtefactos (map triplicoRareza)

triplicoRareza :: Artefacto -> Artefacto
triplicoRareza unArtefacto = unArtefacto {rareza = (*3) . rareza $ unArtefacto} 

desechoArtefactos :: Tarea
desechoArtefactos = cambiarArtefactos (filter (not . esComun))

ayudarACruzarLaCalle :: Int -> Tarea -----------------
ayudarACruzarLaCalle cantidadDeCuadras = cambiarEpiteto ("Gros" ++ replicate cantidadDeCuadras 'o')

type Debilidad = Heroe -> Bool

data Bestia = Bestia {
    nombreBestia :: Sring,
    debilidad :: Debilidad
}

matarAUnaBestia :: Bestia -> Tarea --------------
matarAUnaBestia unaBestia unHeroe
    | (debilidad unaBestia) unHeroe = cambiarEpiteto ("El asesino de " ++ nombreBestia unaBestia) unHeroe
    | otherwise = cambiarEpiteto "El cobarde" . cambiarArtefactos (drop 1) $ unHeroe



-- Punto 4: MODELAR HERACLES --

heracles :: Heroe
heracles = Heroe "Guardian del Olimpo" 700 [pistola, relampagoDeZeus] [matarAUnaBestia leonDeNemea]

pistola :: Artefacto
pistola = Artefacto "Pistola" 1000


-- Punto 5: MODELAR TAREA --

leonDeNemea :: Bestia
leonDeNemea = Bestia "Leon de Nemea" ((>20) . length . epiteto)



-- Punto 6: QUE EL HEROE HAGA UNA TAREA --

hacerTarea :: Tarea -> Tarea
hacerTarea unaTarea unHeroe = agregarTarea unaTarea (unaTarea unHeroe)

agregarTarea :: Tarea -> Tarea
agregarTarea unaTarea unHeroe = unHeroe {tareas = unaTarea : tareas unHeroe}



-- Punto 7: QUE PRESUMA EL HEROE --

presumir :: Heroe -> Heroe -> (Heroe, Heroe)
presumir unHeroe otroHeroe
    | reconocimiento unHeroe   > reconocimiento otroHeroe   = (unHeroe, otroHeroe)
    | reconocimiento unHeroe   < reconocimiento otroHeroe   = (otroHeroe, unHeroe)
    | sumatoriaRarezas unHeroe > sumatoriaRarezas otroHeroe = (unHeroe, otroHeroe)
    | sumatoriaRarezas unHeroe < sumatoriaRarezas otroHeroe = (otroHeroe, unHeroe)
    | otherwise = presumir (realizarLabor (tareas otroHeroe) unHeroe) (realizarLabor (tareas unHeroe) otroHeroe)

sumatoriaRarezas :: Heroe -> 


-- Punto 9: QUE EL HEROE HAGA TAREAS --

realizarLabor :: [Tarea] -> Heroe -> Heroe
realizarLabor unasTareas unHeroe = foldl (flip hacerTarea) unHeroe unasTareas