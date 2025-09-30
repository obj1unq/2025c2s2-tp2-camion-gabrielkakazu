import camion.*
import caminos.*

object knightRider {
	method peso() { return 500 }
	method nivelPeligrosidad() { return 10 }

	method bultos() {return 1}

	method accidente() {
		// console.println("accidente sin efecto en KITT") 
		// le agregué el print para chequear que el testeo el método accidente() sí funcionaba dentro de un embalaje
	}
}

object arenaAGranel {
	var property peso = 0
	method nivelPeligrosidad() { return 1 }

	method bultos() {return 1}

	method accidente() {
		peso += 20
	}

}

object bumblebee {
	var property estado = auto

	method transformar() {
		 estado = estado.transformar()
	}

	method peso() { return 800 }

	method nivelPeligrosidad() = estado.nivelPeligrosidad()

	method bultos() {return 2}

	method accidente() {
		self.transformar()
	}
}
object auto {
  method nivelPeligrosidad() = 15
   method transformar() { return robot }
}
object robot {
  method nivelPeligrosidad() = 30
  method transformar() { return auto }
}

object paqueteLadrillos {
	const peso = 2
	var property cantidad = 0

	method peso() {
		return peso * cantidad
	}

	method nivelPeligrosidad() { return 2 }

	/* method bultos() {
		return if (cantidad >300) {
			3} else if (cantidad <=100) {
				1
			} else {
				2
			}
	}*/

	method bultos() = if (cantidad.between(101, 300)) 2 else if (cantidad > 300) 3 else 1

	method accidente() {
		cantidad = (cantidad - 12).max(0)
	}

}

object bateriaAntiAerea {
    var property misiles = conMisiles
    method peso() = misiles .peso()
    method nivelPeligrosidad() = misiles.nivelPeligrosidad()
    method bultos() = misiles.bultos()
    method accidente() { misiles = misiles.accidente() }
}
object conMisiles {
    method peso() = 300
    method nivelPeligrosidad() = 100
    method bultos() = 2
    method accidente() {return sinMisiles }
}
object sinMisiles {
    method peso() = 200
    method nivelPeligrosidad() = 0
    method bultos() = 1
    method accidente() {return self}
}

/*
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
}*/

object residuosRadiactivos	{
	var property peso = 0

	method nivelPeligrosidad() {return 200}

	method bultos() {return 1}

	method accidente() {
		peso += 15
	}
}

object embalajeSeguridad {
	var embalado = knightRider

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

object contenedorPortuario {
	const property cosas = #{}
	const tara = 100
	
	method estaVacio() {return cosas.isEmpty()}

	method cargar(cosa) {
		cosas.add(cosa)
	}

	method cargarMuchas(variasCosas) {
		cosas.addAll(variasCosas)
	}

	method descargar(cosa) {
		cosas.remove(cosa)
	}
	
	method hayAlgoQuePesa(kilos) {
		return cosas.any{cosa => cosa.peso() == kilos}
	}

	method tara() {return tara}
	
	method peso() {
		return tara + cosas.sum({cosa => cosa.peso()})
	}

	method nivelPeligrosidad() {
		return cosas.map({cosa => cosa.nivelPeligrosidad()}).maxIfEmpty({0})
	}

	method bultos() {
		return 
			1 + cosas.sum({cosa => cosa.bultos()} )
	}

	method accidente() {
		cosas.forEach({cosa => cosa.accidente()})
	}
}


//DESTINO
object almacen{
	const property cosas = #{}

	method cargarMuchas(variasCosas) {
		cosas.addAll(variasCosas)
	}
}
