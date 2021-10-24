/*
 * Carpas
 * 
 * Las carpas cerveceras tienen:
 * 
 * un límite de gente admitida, 
 * 
 * algunas tienen una banda para tocar música tradicional (esto debe indicarse 
 * para cada una),
 * 
 * y por supuesto que todas venden jarras de cerveza.
 * 
 * Cada carpa vende cerveza de únicamente una marca (que depende de cada carpa).
 * 
 * Requerimientos - segunda parte
 * 
 * Se agregan estos requerimientos
 * 
 * Saber si una persona quiere entrar a una carpa. Para esto hay que mirar si 
 * la marca de cerveza que venda la carpa le gusta a la persona y si cumple su 
 * preferencia sobre que haya o no haya música (ojo con esto: si a la persona 
 * le gusta la música tradicional tiene que haber música en la carpa, y si no 
 * le gusta, entonces no puede haber música).
 * 
 * Los alemanes, además, requieren que haya una cantidad par de personas en la 
 * carpa (antes de entrar ellos).
 * 
 * Saber si una carpa deja ingresar a una persona, o sea, si dejándola entrar 
 * no supera su límite de personas y la persona no está ebria.
 * 
 * Saber si una persona puede entrar a una carpa, es decir, si quiere entrar a 
 * la carpa y la carpa lo deja entrar.
 * 
 * Hacer que una persona efectivamente entre a una carpa. Si una persona quiere 
 * ingresar a una carpa y no puede por la falla de alguna condición resuelta en 
 * los puntos anteriores, generar un error.
 * 
 * Hacer que una carpa le sirva una jarra de cerveza a una persona. Se debe 
 * indicar la capacidad de la jarra que se está vendiendo.
 * 
 * Si la persona no está en la carpa, generar un error.
 * 
 * Nota: es conveniente que el objeto que representa a la jarra vendida se cree 
 * en la acción de servir. La marca es la que vende la carpa, la capacidad se 
 * está indicando.
 * 
 * Saber cuantos ebrios empedernidos hay dentro de una carpa. Los ebrios 
 * empedernidos son los ebrios que todas las jarras que compraron, son de 1 
 * litro ó más.
 * 
 * Saber si una persona es patriota, o sea, si todas las jarras de cerveza que 
 * compró son del país del que proviene. P.ej. un alemán es patriota si todas 
 * las jarras de cerveza que compró son alemanas.
 * 
 */
import MarcasYJarras.*
import Personas.*

class Carpa {

  const property limiteGente = 0
  const property tieneBandaMusical = false
  const property cervezaTirada
  const personas = []

  method cantidadDePersonas() = personas.size()

  method estaPersona(unaPersona) = personas.any({ p => p == unaPersona })

  method dejaIngresar(unaPersona) = (not unaPersona.estaEbria()) and (limiteGente <= self.cantidadDePersonas() + 1)

  method agregarPersona(unaPersona) {
    personas.add(unaPersona)
  }

  method servirUnaJarra(unaCapacidad, unaPersona) {
    if (self.estaPersona(unaPersona)) {
      unaPersona.comprarJarra(new Jarra(capacidad = unaCapacidad, marca = cervezaTirada, carpa = self))
    } else {
      self.error("Persona no se encuentra en la carpa, para servir jarra.")
    }
  }

  method ebriosEmpedernidos() = personas.count({ p => p.jarrasCompradas().all({ j => j.capacidad() >= 1}) })

  method esHomogenea() = personas.all({ p => p.paisDeNacimiento() == personas.first().paisDeNacimiento() })

  method personasQueNoSeLesSirvio() = personas.filter({ p => p.jarrasCompradas().map({ j => j.carpa()}).contains(self) })

}

