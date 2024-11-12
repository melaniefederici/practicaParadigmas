import Filosofo.*

class Partido {
  const argumentos
  const filosofo

  method esBueno() = self.tieneBuenosArgumentos() && filosofo.estaEnLoCorrecto()

  method tieneBuenosArgumentos() = self.cantidadDeArgumentosEnrriquesedores() > self.cantidadDeArgumentos()/2

  method cantidadDeArgumentos() = argumentos.size()

  method cantidadDeArgumentosEnrriquesedores() = argumentos.count {argumento => argumento.esEnrriquesedor()}
}

class Discusion {   //inherits Partido
  const unPartido
  const otroPartido

  method esBuena() = unPartido.esBueno() && otroPartido.esBueno()
}


