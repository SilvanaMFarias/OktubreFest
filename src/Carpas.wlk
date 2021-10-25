import MarcasYJarras.*
import Personas.*

class Carpa {

  const property limiteGente = 0
  const property tieneBandaMusical = false
  const property cervezaTirada
  const personas = []
  var property tipoRecargo = "Fijo"

  method personas()= personas
  
  method cantidadDePersonas() = personas.size()

  method estaPersona(unaPersona) = personas.any({ p => p == unaPersona })

  method dejaIngresar(unaPersona) = (not unaPersona.estaEbria()) and (self.cantidadDePersonas() + 1 <= limiteGente)

  method agregarPersona(unaPersona) {
    personas.add(unaPersona)
  }

  method servirUnaJarra(unaCapacidad, unaPersona) {
    if (self.estaPersona(unaPersona)) {
      unaPersona.comprarJarra(new Jarra(capacidad = unaCapacidad, marca = cervezaTirada, carpa = self, precio = self.precioVentaPorLitro() * unaCapacidad))
    } else {
      self.error("La persona no se encuentra en la carpa para poder servirle la jarra.")
    }
  }

  method ebriosEmpedernidos() = personas.count({ p => p.esEbrioEmpedernido()})

  method esHomogenea() = personas.all({ p => p.paisDeNacimiento() == personas.first().paisDeNacimiento() })

  
  method personasQueNoSeLesSirvio() {
  	const personasConConsumo = personas.filter({ p => p.jarrasCompradas().map({ j => j.carpa() }).contains(self) }).asSet()
  	return personas.asSet().difference(personasConConsumo)
  }

  method recargoFijo() = 0.30

  method recargoPorCantidad() = if (self.cantidadDePersonas() > limiteGente / 2) 0.40 else 0.25

  method recargoPorEbriedad() = if (personas.count({ p => p.estaEbria() }) >= self.cantidadDePersonas() * 0.75) 0.50 else 0.20

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

  method precioVentaPorLitro() = cervezaTirada.precioPorLitro() * (1 + self.recargo())

}

