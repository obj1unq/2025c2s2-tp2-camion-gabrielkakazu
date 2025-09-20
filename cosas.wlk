object knightRider {
	method peso() { return 500 }
	method nivelPeligrosidad() { return 10 }

	method siEsPesoPar() {
		return self.peso().even()
	}

	method bultos() {return 1}

	method accidente() {
		console.println("accidente sin efecto en KITT")
	}
}

object arenaAGranel {
	var property peso = 0
	method nivelPeligrosidad() { return 1 }

	method siEsPesoPar() {
		return self.peso().even()
	}

	method bultos() {return 1}

	method accidente() {
		peso += 20
	}

}

object bumblebee {
	var property transformadoAuto = false

	method transformar() {
		transformadoAuto = !transformadoAuto
	}
	method peso() { return 800 }
	method nivelPeligrosidad() { if (transformadoAuto) {
		return 15 
		} else {
			return 30
		}
	}

	method siEsPesoPar() {
		return self.peso().even()
	}

	method bultos() {return 2}

	method accidente() {
		self.transformar()
	}
}

object paqueteLadrillos {
	const peso = 2
	var property cantidad = 0

	method peso() {
		return peso * cantidad
	}

	method nivelPeligrosidad() { return 2 }

	method siEsPesoPar() {
		return self.peso().even()
	}

	method bultos() {
		return if (cantidad >300) {
			3} else if (cantidad <=100) {
				1
			} else {
				2
			}
	}

	method accidente() {
		cantidad = (cantidad - 12).max(0)
	}

}


object bateriaAntiAerea {
	var property conMisiles = true

	method peso() {return if (conMisiles) {
		300} else {200 }
	}

	method nivelPeligrosidad() {return 
		if (conMisiles) {100
		} else {0 }
		}

	method siEsPesoPar() {
		return self.peso().even()
	}

	method bultos() {
		return if (conMisiles) {2
			} else {1} }

	method accidente() {
		self.conMisiles(false)
	}
}

object residuosRadiactivos	{
	var property peso = 0

	method nivelPeligrosidad() {return 200}

	method siEsPesoPar() {
		return self.peso().even()
	}

	method bultos() {return 1}

	method accidente() {
		peso += 15
	}
}

object embalajeSeguridad {
	var embalado = knightRider
	var property peso = 0

	method nivelPeligrosidad() {
		return embalado.nivelPeligrosidad()/ 2}

	method embalar(_cosa) {
		embalado = _cosa
	}

	method peso() { return embalado.peso()}

	method bultos() {return 2}

	method accidente() {
		embalado.accidente()
	}

}

