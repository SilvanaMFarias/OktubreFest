import MarcasYJarras.*
import Carpas.*

class Persona {

  const property peso
  const property jarrasCompradas = []
  const property leGustaEscucharMusicaTradicional
  const property nivelDeAguante

  method comprarJarra(unaJarra) {
    jarrasCompradas.add(unaJarra)
  }

  method alcoholIngerido() = self.jarrasCompradas().sum({ j => j.contenidoDeAlcohol() })

  method estaEbria() = (self.alcoholIngerido() * peso) > nivelDeAguante

  method leGustaLaMarca(unaMarca)

  method quiereEntrarALaCarpa(unaCarpa) = self.leGustaLaMarca(unaCarpa.cervezaTirada()) and /* XNOR */ ( self.leGustaEscucharMusicaTradicional() and unaCarpa.tieneBandaMusical() or not self.leGustaEscucharMusicaTradicional() and not unaCarpa.tieneBandaMusical() )

  method puedeEntrarALaCarpa(unaCarpa) = self.quiereEntrarALaCarpa(unaCarpa) and unaCarpa.dejaIngresar(self)

  method entrarALaCarpa(unaCarpa) {
    if (self.puedeEntrarALaCarpa(unaCarpa)) {
      unaCarpa.agregarPersona(self)
    } else {
      self.error("La persona no puede entrar a la carpa deseada.")
    }
  }

  method paisDeNacimiento()

  method esPatriota() = jarrasCompradas.all({ j => j.marca().paisDeFabricacion() == self.paisDeNacimiento() })

}

class Belga inherits Persona {

  override method leGustaLaMarca(unaMarca) = unaMarca.contenidoDeLupulo() > 4

  override method paisDeNacimiento() = "Bélgica"

}

class Checo inherits Persona {

  override method leGustaLaMarca(unaMarca) = unaMarca.graduacion( ) > 8

  override method paisDeNacimiento() = "República Checa"

}

class Aleman inherits Persona {

  override method leGustaLaMarca(unaMarca) = true

  override method quiereEntrarALaCarpa(unaCarpa) = super(unaCarpa) and unaCarpa.cantidadDePersonas().even()

  override method paisDeNacimiento() = "Alemania"

}

