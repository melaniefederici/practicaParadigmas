import Actividad.*

class Filosofo {
    var property nombre
    //var property edad
    var property honorificos = []
    var property actividades = []
    //var property nivelDeIluminacion
    var nivelDeIluminacion
    //var property diasVividos
    var diasVividos

    method nivelDeIluminacion() = nivelDeIluminacion  //nuevo

    //method presentarse() = self.nombre() && honorificos.join(", ")
    method presentarse() = self.nombre() + self.honorificos().join(", ")

    method estaEnLoCorrecto() = self.nivelDeIluminacion() > 1000

    method disminuirNivelIluminacion(unNivel) {
        nivelDeIluminacion -= unNivel
    }

    method aumentarNivelIluminacion(unNivel) {
        nivelDeIluminacion += unNivel
    }

    method agregarHonorifico(unHonorifico) {
        honorificos.add(unHonorifico)
    }

    method rejuvenecer(unosDias){
        diasVividos -= unosDias
    }

    method envejecer(unosDias){
        diasVividos += unosDias
    }

    // method cumpleAnios() {
    //     if(diasVividos % 365 == 0){
    //         nivelDeIluminacion += 10
    //         if (edad == 60) {
    //             agregarHonorifico("el sabio")
    //         }
    //     }
    // }
    method cumpleAnios() = diasVividos % 365 == 0

    method edad() = diasVividos.div(365)     //nuevo

    method vivirUnDia() {
        self.envejecer(1)
        self.realizarActividades()
        self.verificarCumpleanios()
    }

    method realizarActividades(){
        actividades.forEach {actividad => actividad.apply(self)}
    }

    method verificarCumpleanios() {
        if(self.cumpleAnios()) {
            self.aumentarNivelIluminacion(10)
            self.verificarCumple60()
        }
    }

    method verificarCumple60(){
        if (self.edad() == 60) {
            self.agregarHonorifico("el sabio")
        }
    }


    
}

class FilosofoContemporaneo inherits Filosofo {
    const amanteDeLaBotanica = true

    override method presentarse() = "Hola"

    override method nivelDeIluminacion() = if (!amanteDeLaBotanica) nivelDeIluminacion*5 else super()
}