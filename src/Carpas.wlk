import MarcasYJarras.*
import Personas.*

class Carpa {

  const property limiteGente = 0
  const property tieneBandaMusical = false
  const property cervezaTirada
  const personas = []
  var property tipoRecargo = "Fijo"

  method cantidadDePersonas() = personas.size()

  method estaPersona(unaPersona) = personas.any({ p => p == unaPersona })

  method dejaIngresar(unaPersona) = (not unaPersona.estaEbria()) and (limiteGente <= self.cantidadDePersonas() + 1)

  method agregarPersona(unaPersona) {
    personas.add(unaPersona)
  }

  method servirUnaJarra(unaCapacidad, unaPersona) {
    if (self.estaPersona(unaPersona)) {
      unaPersona.comprarJarra(new Jarra(capacidad = unaCapacidad, marca = cervezaTirada, carpa = self, precio = self.precioVentaPorLitro() * unaCapacidad))
    } else {
      self.error("Persona no se encuentra en la carpa, para servir jarra.")
    }
  }

  method ebriosEmpedernidos() = personas.count({ p => p.jarrasCompradas().all({ j => j.capacidad() >= 1}) })

  method esHomogenea() = personas.all({ p => p.paisDeNacimiento() == personas.first().paisDeNacimiento() })

  method personasQueNoSeLesSirvio() = personas.filter({ p => p.jarrasCompradas().map({ j => j.carpa()}).contains(self) })

  method recargoFijo() = 0.30

  method recargoPorCantidad() = if (self.cantidadDePersonas() > limiteGente / 2) 0.40 else 0.25

  method recargoPorEbriedad() = if (personas.count({ p => p.estaEbria() }) > self.cantidadDePersonas() * 0.75) 0.50 else 0.20

  method recargo() {
    var porcentaje
    if (tipoRecargo == "Por Cantidad") {
      porcentaje = self.recargoPorCantidad()
    } else if (tipoRecargo == "Por Ebriedad") {
      porcentaje = self.recargoPorEbriedad()
    } else if (tipoRecargo == "Fijo") {
      porcentaje = self.recargoFijo()
    } else {
      self.error("Tipo de recargo no válido. (Fijo|Por Cantidad|Por Ebriedad)")
    }
    return porcentaje
  }

  method precioVentaPorLitro() = cervezaTirada.precioPorLitro * (1 + self.recargo())

}

