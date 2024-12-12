import Panelista.*
import Tematica.*

class Programa {
    var property panelistas
    var property tematicas
    var emisionFinalizada = false

    method sePuedeEmitir() {
        self.cantidadDePanelistas() >= 2
        self.mayoriaDeTematicasIntesesantes()
    }

    method cantidadDePanelistas() = self.panelistas().size()

    method mayoriaDeTematicasIntesesantes() {
        self.cantidadTematicasInteresantes() / self.cantidadDeTematicas() > 0.5
    }

    method cantidadTematicasInteresantes() = self.tematicas().filter{tematica => tematica.esInteresante()}.size()
    method cantidadDeTematicas() = self.tematicas().size()

    method emitir() {
        self.tematicas().forEach{ tematica => tematica.opinarsePor(self.panelistasOpinan(tematica))}
        emisionFinalizada = true
    }
    
    method panelistasOpinan(unaTematica) {
        self.panelistas().forEach{ panelista =>
            panelista.opinarSobre(unaTematica)
            panelista.darRemateGracioso(unaTematica)}
    }

    method verificarFinalizacionDePrograma() {
        if(!emisionFinalizada) {
            throw new DomainException(message = "La emision del progrma no finalizo")
        }
    }

    method panelistaEstrella(unPanelista) {
        self.verificarFinalizacionDePrograma()
        return panelistas.max{panelista => panelista.cantidadDePuntosEstrella()}
    }
}