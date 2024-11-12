class Argumento {
    var property descripcion
    var property naturaleza

    method esEnrriquesedor() = naturaleza.enrriquesedor(self)

    method cantidadDePalabras() = descripcion.split(" ").length()

    method esPregunta() = descripcion.endsWhit("?")
}




object estoico {
    method enrriquesedor(unArgumento) = true
}

//class NaturalezaMoralista inherits Argumento
object moralista{
    method enrriquesedor(unArgumento) = unArgumento.cantidadDePalabras() > 10
}

//class NaturalezaMoralista inherits Argumento
object esceptico{
    method enrriquesedor(unArgumento) = unArgumento.esPrehunta()
}

//class NaturalezaMoralista inherits Argumento
object cinico {
    method enrriquesedor() = 1.randomUpTo(100) <= 30
}

class NaturalezaCombinada {    //inherits Argumento
    const naturalezas

    method enrriquesedor(unArgumento) = naturalezas.all { naturaleza => naturaleza.enrriquesedor(unArgumento)}
    
}