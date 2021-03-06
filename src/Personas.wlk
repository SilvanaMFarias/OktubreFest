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

  method quiereEntrarALaCarpa(unaCarpa) = self.leGustaLaMarca(unaCarpa.cervezaTirada()) and self.leGustaEscucharMusicaTradicional() == unaCarpa.tieneBandaMusical()

  method puedeEntrarALaCarpa(unaCarpa) = self.quiereEntrarALaCarpa(unaCarpa) and unaCarpa.dejaIngresar(self)

  method entrarALaCarpa(unaCarpa) {
    if (self.puedeEntrarALaCarpa(unaCarpa)) {
      unaCarpa.agregarPersona(self)
    } else {
      self.error("La persona no puede entrar a la carpa deseada.")
    }
  }

  method esEbrioEmpedernido() = self.estaEbria() and jarrasCompradas.all({ j => j.capacidad() >= 1 })

  method paisDeNacimiento()

  method esPatriota() = jarrasCompradas.all({ j => j.marca().paisDeFabricacion() == self.paisDeNacimiento() })

  method marcasCompradas() = jarrasCompradas.map({ j => j.marca() }).asSet()

  method marcasDiferentes(unaPersona) {
    var marcas
    if (self.marcasCompradas().size() > unaPersona.marcasCompradas().size()) {
      marcas = self.marcasCompradas().intersection(unaPersona.marcasCompradas())
    } else {
      marcas = unaPersona.marcasCompradas().intersection(self.marcasCompradas())
    }
    return marcas
  }

  method marcasComunes(unaPersona) = (self.marcasCompradas()).intersection(unaPersona.marcasCompradas())

  method esCompatibleCon(unaPersona) = self.marcasComunes(unaPersona).size() > self.marcasDiferentes(unaPersona).size()

  method carpasDondeLeSirvieron() = self.jarrasCompradas().map({ j => j.carpa() }).asSet()

  method indices() = (1 .. jarrasCompradas.size() - 1)

  method estaEntrandoEnElVicio() {
    return self.indices().all({ i => jarrasCompradas.get(i - 1).capacidad() <= jarrasCompradas.get(i).capacidad() })
  }

  method gastoTotalEnCerveza() = jarrasCompradas.sum({ j => j.precio() })

  method jarraMasCara() = jarrasCompradas.max({ j => j.precio() })

}

class Belga inherits Persona {

  override method leGustaLaMarca(unaMarca) = unaMarca.contenidoDeLupulo() > 4

  override method paisDeNacimiento() = "B??lgica"

}

class Checo inherits Persona {

  override method leGustaLaMarca(unaMarca) = unaMarca.graduacion( ) > 8

  override method paisDeNacimiento() = "Rep??blica Checa"

}

class Aleman inherits Persona {

  override method leGustaLaMarca(unaMarca) = true

  override method quiereEntrarALaCarpa(unaCarpa) = super(unaCarpa) and unaCarpa.cantidadDePersonas().even()

  override method paisDeNacimiento() = "Alemania"

}

