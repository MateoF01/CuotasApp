//
//  ViewModel.swift
//  Contador de Cuotas
//
//  Created by Mateo Fernandez on 05/12/2023.
//

import Foundation

class MainViewModel: ObservableObject {
    @Published var productos: [Producto] = []

    func guardarProductos(){
        DataManager.shared.guardarProductos(productos)
    }
    
    func cargarProductos () {
        let productosCargados = DataManager.shared.cargarProductos()
        productos = productosCargados
    }

    func agregarProducto(nombre: String, cuotasRestantes: Int, precioPorCuota: Int, nombreTarjeta: String) {
        let nuevoProducto = Producto(nombre: nombre, cuotasRestantes: cuotasRestantes, precioPorCuota: precioPorCuota, nombreTarjeta: nombreTarjeta)
        productos.append(nuevoProducto)
    }

    func calcularTotalPorMes() -> Int {
        var totalPorMes: Int = 0

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
    
    func eliminarProducto(producto: Producto) {
        // Implementa lógica para eliminar el producto de tu array
        if let index = productos.firstIndex(where: { $0.id == producto.id }) {
            productos.remove(at: index)
        }
    }
    
    

}

