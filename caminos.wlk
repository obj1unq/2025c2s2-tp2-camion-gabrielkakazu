import cosas.*
import camion.*

// CAMINOS
object ruta9 {
	
    method puedeCircular(vehiculo) {
        return vehiculo.puedeCircularPorRuta(20)
    }
}

object caminoVecinal {

    var property pesoMaximoPermitido = 0

	method puedeCircular(vehiculo) {
        return vehiculo.pesoTotal() < pesoMaximoPermitido
    }
}