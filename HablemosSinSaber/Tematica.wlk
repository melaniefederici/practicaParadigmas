import Panelista.*

class Tematica {
    var property titulo

    method cantidadDePalabras() = self.titulo().words()

    method esInteresante() = false

    method opinarsePor(unPanelista) {
        unPanelista.opinar(self)
    }
}

class Deportiva inherits Tematica {
    method puntosPorOpinarDeportiva() = 5

    override method esInteresante() = self.titulo().contains("Messi")
}

class Farandula inherits Tematica {
    var property involucrados 

    method cantidadDeInvolucrados() = involucrados.size()

    override method esInteresante() = self.cantidadDeInvolucrados() >= 3
}

class Filosofica inherits Tematica {
    override method esInteresante() = self.cantidadDePalabras() > 20
}

class TematicasMixtas inherits Tematica {
    var property tematicas

    method tituloDeTematicas() = tematicas.map{tematica => tematica.titulo()}
    method tituloTematicaMixta() = self.tituloDeTematicas().join(" ")
    
    override method esInteresante() = tematicas.any{tematica => tematica.esInteresante()}

    override method opinarsePor(unPanelista) {
        tematicas.forEach{tematica => tematica.opinarsePor(unPanelista)}
    }
}