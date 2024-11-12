import Filosofo.*

object tomarVino {
    method apply(unFilosofo){
        unFilosofo.disminuirNivelIluminacion(10)
        unFilosofo.agregarHonorifico("el sabio")
    }
}

class JuntarseEnElAgora {   //inherits Filosofo 
    const otroFilosofo

    method apply(unFilosofo){
        unFilosofo.aumentarNivelIluminacion(otroFilosofo.nivelDeIluminacion() * 0.1)
    }
}

object admirarPaisaje {
    method apply(unFilosofo){
        //No hace nada
    }
}

class MeditarBajoCascada {    //inherits Filosofo
    const metros

    method apply(unFilosofo) {
        unFilosofo.aumentarNivelIluminacion(10*metros)
    }
}

class PracticarDeporte {    //nuevo
    const deporte

    method apply(unFilosofo){
        unFilosofo.rejuvenecer(deporte.diasRejuvenecidos())
    }
}

object futbol {
    method diasRejuvenecidos() = 1
}

object polo {
    method diasRejuvenecidos() = 2
}

object waterpolo {
    method diasRejuvenecidos() = polo.diasRejuvenecidos()*2
}

