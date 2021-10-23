import MarcasYJarras.*

class Persona {
	const property peso
	const property jarrasCompradas = []
	const property leGustaEscucharMusicaTradicional
	const property nivelDeAguante
	
	method comprarJarra(unaJarra) {jarrasCompradas.add(unaJarra)}
	
	method alcoholIngerido() = self.jarrasCompradas().sum({ j => j.contenidoDeAlcohol()})
	
	method estaEbria()= (self.alcoholIngerido() * peso) > nivelDeAguante
	
	method leGustaLaMarca(unaMarca)
	
}

class Belga inherits Persona{
	override method leGustaLaMarca(unaMarca) = unaMarca.contenidoDeLupulo() > 4
}

class Checo inherits Persona{
	override method leGustaLaMarca(unaMarca) = unaMarca.graduacion( ) > 8
}

class Aleman inherits Persona{
	override method leGustaLaMarca(unaMarca) = true
}