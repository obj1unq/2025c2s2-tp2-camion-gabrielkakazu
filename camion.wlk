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
}

