import cosas.*

object camion {
	const property cosas = #{}
		
	method cargar(unaCosa) {
		self.validarCargar(unaCosa)
		cosas.add(unaCosa)
	}

	method validarCargar(unaCosa){
		if (cosas.contains(unaCosa)){
			self.error("deposito ya tiene " + unaCosa + ", no se puede cargar algo ya cargado")
		}
	}

	method descargar(unaCosa) {
		self.validarDescargar(unaCosa)
		cosas.remove(unaCosa)
	}

	method validarDescargar(unaCosa){
		return if (not self.tieneCargado(unaCosa)) {
			self.error("no se tiene cargado " + unaCosa)
		}
	}

	method estaVacio() {return cosas.isEmpty()}

	method tieneCargado(unaCosa) {
		return cosas.contains(unaCosa)
	}

	method tiene(otrasCosas){
		return otrasCosas.all{unaCosa => self.tieneCargado(unaCosa)}
	}

	method soloCargaPar(){
		return cosas.all{unaCosa => unaCosa.siEsPesoPar()}
	}
//PESO
	method hayAlgoQuePesa(kilos) {
		return cosas.any{unaCosa => unaCosa.peso() == kilos}
	}

	method excedidoPeso() {
		return self.pesoTotal() > self.pesoMaximo()
	}

	var property pesoMaximo =  2500

	const tara = 1000
	method tara() {return 1000}

	method pesoTotal() {
		return tara + cosas.sum({cosa => cosa.peso()})
	}

//PELIGROSIDAD
	method findAlgoConPeligrosidad(peligrosidad){
		return cosas.find({cosa => cosa.nivelPeligrosidad() == peligrosidad})
	}

	method cosasPeligrosasQue(condicion){
		return cosas.filter({cosa => condicion})
	}

	method cosasMasPeligrosasQue(nivelPeligrosidad){
		return cosas.filter({cosa => cosa.nivelPeligrosidad() > nivelPeligrosidad})
	}

	method cosasMasPeligrosasQueLaCosa(unaCosa){
		return cosas.filter({cosa => cosa.nivelPeligrosidad() > unaCosa.nivelPeligrosidad()})
	}

//RUTA
	method puedeCircularPorRuta(nivel){
		return not self.excedidoPeso() 
			&& self.cosasMasPeligrosasQue(nivel).isEmpty()
	}
}



