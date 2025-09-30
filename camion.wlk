import cosas.*

object camion {
	const property cosas = #{}

	const pesoMaximo =  2500
	const tara = 1000
	
//DEPOSITO Y CARGAS 
	method cargar(cosa) {
		self.validarCargar(cosa)
		cosas.add(cosa)
	}

	method cargarMuchas(variasCosas) {
		variasCosas.forEach({cosa => self.validarCargar(cosa)})
		cosas.addAll(variasCosas)
	}

	method validarCargar(cosa){
		if (cosas.contains(cosa)){
			self.error("deposito ya tiene " + cosa + ", no se puede cargar algo ya cargado")
		}
	}

	method descargar(cosa) {
		self.validarDescargar(cosa)
		cosas.remove(cosa)
	}

	method descargarTodo() {
		cosas.clear()
	}

	method validarDescargar(cosa){
		if (not self.tieneCargado(cosa)) {
			self.error("no se tiene cargado " + cosa)
		}
	}

	method estaVacio() {return cosas.isEmpty()}

	method tieneCargado(cosa) {
		return cosas.contains(cosa)
	}

	method tiene(otrasCosas){
		return otrasCosas.all{cosa => self.tieneCargado(cosa)}
	}

		method soloCargaPar() = cosas.all { cosa => cosa.peso().even() }

	method totalBultos() {
		return cosas.sum({cosa => cosa.bultos()})
	}

//PESO


	method hayAlgoQuePesa(kilos) {
		return cosas.any{cosa => cosa.peso() == kilos}
	}

	method excedidoPeso() {
		return self.pesoTotal() > pesoMaximo
	}
	
	method tara() {return tara}

	method pesoTotal() {
		return tara + cosas.sum({cosa => cosa.peso()})
	}

	method tieneAlgoQuePesaEntre(min, max) {
		return cosas.any{cosa => cosa.peso().between(min, max)  
		}
	}

	method laCosaMasPesada() {
		self.validarCosaMasPesada()
		return cosas.max({cosa => cosa.peso()})
	}

	method validarCosaMasPesada() {
		if (self.estaVacio()) {
			self.error("no se puede calcular cosa más pesada porque el camión está vacío")
		}
	}

	method todosLosPesosDESC() {
		const listaDeCosas = cosas.asList()
		const ordenPorPesos = listaDeCosas.sortedBy({
			unaCosa, otraCosa => unaCosa.peso() > otraCosa.peso()
		})
		return ordenPorPesos.map({cosa => cosa.peso()})
	}

//PELIGROSIDAD
	method findAlgoConPeligrosidad(peligrosidad){
		return cosas.find({cosa => cosa.nivelPeligrosidad() == peligrosidad})
	}

	method cosasPeligrosasQue(criterio) {
    	return cosas.filter(criterio)
	}
	method cosasMasPeligrosasQue(nivelPeligrosidad) = self.cosasPeligrosasQue({ cosa => cosa.nivelPeligrosidad() > nivelPeligrosidad })

	method cosasMasPeligrosasQueLaCosa(unaCosa) = self.cosasMasPeligrosasQue(unaCosa.nivelPeligrosidad())
/*
	method cosasPeligrosasQue(condicion){
		return cosas.filter({cosa => condicion})
	}

	method cosasMasPeligrosasQue(nivelPeligrosidad){
		return cosas.filter({cosa => cosa.nivelPeligrosidad() > nivelPeligrosidad})
	}

	method cosasMasPeligrosasQueLaCosa(unaCosa){
		return cosas.filter({cosa => cosa.nivelPeligrosidad() > unaCosa.nivelPeligrosidad()})
	}*/

//RUTA
	method puedeCircularPorRuta(nivel){
		return not self.excedidoPeso() 
			&& self.cosasMasPeligrosasQue(nivel).isEmpty()
	}

// TRANSPORTAR

	method transportar(destino, camino) {
			self.validarCamino(camino)
			destino.cargarMuchas(cosas)
			self.descargarTodo()
	}

	method validarCamino(camino) {
		if (not camino.puedeCircular(self)){
				self.error("no puede circular por el camino")
			}
	}

	method sufreAccidente() {
		cosas.forEach({cosa => cosa.accidente()})
	}

}




