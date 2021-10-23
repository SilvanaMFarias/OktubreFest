import MarcasYJarras.*

class Persona {
	const property peso
	const property jarrasCompradas = []
	const property leGustaEscucharMusicaTradicional
	const property nivelDeAguante
	
	method comprarJarra(unaJarra) {jarrasCompradas.add(unaJarra)}
	
	method alcoholIngerido() = self.jarrasCompradas().sum({ j => j.contenidoDeAlcohol()})
	
	method estaEbria()= (self.alcoholIngerido() * peso) > nivelDeAguante
	
}