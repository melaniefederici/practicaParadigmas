import Tematica.*

class Panelista {
    var puntosEstrella
    method darRemateGracioso (unaTematica)

    method opinarSobre(unaTematica) {
        puntosEstrella += 1
    }

    method cantidadPuntosEstrella() = puntosEstrella
}

class Celebridad inherits Panelista {
    override method darRemateGracioso (unaTematica) {
      puntosEstrella += 3
    }

    method estaInvolucrado(unaTematica) {
        puntosEstrella += unaTematica.cantidadDeInvolucrados()
    }
}

class Colorado inherits Panelista {
    var gracia

    override method darRemateGracioso (unaTematica) {
      puntosEstrella += gracia * (1/5)
      gracia += 1
    }
}

class ColoradoConPeluca inherits Colorado {
    override method darRemateGracioso (unaTematica) {
        super(unaTematica)
        puntosEstrella += 1
        gracia += 1
    }
}

class Viejo inherits Panelista {
    override method darRemateGracioso (unaTematica) {
        puntosEstrella += unaTematica.cantidadDePalabras()
    }
}

class Deportivo inherits Panelista {
    method esDivertido() = false

    override method opinarSobre(unaTematica) {
        puntosEstrella += unaTematica.puntosPorOpinarDeportiva()
    }
}
