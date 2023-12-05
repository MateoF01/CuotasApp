//
//  ViewModel.swift
//  Contador de Cuotas
//
//  Created by Mateo Fernandez on 05/12/2023.
//

import Foundation

class MainViewModel: ObservableObject {
    @Published var productos: [Producto] = []

    func agregarProducto(nombre: String, cuotasRestantes: Int, precioPorCuota: Double, nombreTarjeta: String) {
        let nuevoProducto = Producto(nombre: nombre, cuotasRestantes: cuotasRestantes, precioPorCuota: precioPorCuota, nombreTarjeta: nombreTarjeta)
        productos.append(nuevoProducto)
    }

    func calcularTotalPorMes() -> Double {
        var totalPorMes: Double = 0

        for producto in productos {
            totalPorMes += producto.precioPorCuota
        }

        return totalPorMes
    }
    
    func actualizarCuotas() {
        var nuevosProductos: [Producto] = []

        for producto in productos {
            if producto.cuotasRestantes > 0 {
                producto.cuotasRestantes -= 1
                if producto.cuotasRestantes > 0 {
                    nuevosProductos.append(producto)
                }
            }
        }

        productos = nuevosProductos
    }
}

