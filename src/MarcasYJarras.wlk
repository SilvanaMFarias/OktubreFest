object graduacionReglamentaria {

  var property graduacion

}

class MarcaDeCerveza {

  const property contenidoDeLupulo
  const property paisDeFabricacion
  const property precioPorLitro

  method graduacion()

}

class Rubia inherits MarcaDeCerveza {

  const property graduacion

}

class Negra inherits MarcaDeCerveza {

  override method graduacion() = graduacionReglamentaria.graduacion().min(contenidoDeLupulo * 2)

}

class Roja inherits Negra {

  override method graduacion() = super() * 1.25

}

class Jarra {

  const property capacidad
  const property marca
  const property carpa
  const property precio

  method contenidoDeAlcohol() = marca.graduacion() * capacidad * 0.01

}

