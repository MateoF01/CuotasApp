//
//  Models.swift
//  Contador de Cuotas
//
//  Created by Mateo Fernandez on 05/12/2023.
//

import Foundation

class Producto: Identifiable, Codable {
    var id = UUID()
    var nombre: String
    var cuotasRestantes: Int
    var precioPorCuota: Int
    var nombreTarjeta: String // Nuevo campo

    init(nombre: String, cuotasRestantes: Int, precioPorCuota: Int, nombreTarjeta: String) {
        self.nombre = nombre
        self.cuotasRestantes = cuotasRestantes
        self.precioPorCuota = precioPorCuota
        self.nombreTarjeta = nombreTarjeta
    }
}

