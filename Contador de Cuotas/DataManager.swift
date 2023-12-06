//
//  DataManager.swift
//  Contador de Cuotas
//
//  Created by Mateo Fernandez on 06/12/2023.
//

import Foundation

class DataManager {
    static let shared = DataManager()

    private let userDefaults = UserDefaults.standard
    private let productosKey = "productos"

    func guardarProductos(_ productos: [Producto]) {
        do {
            let productosData = try JSONEncoder().encode(productos)
            userDefaults.set(productosData, forKey: productosKey)
        } catch {
            print("Error al codificar los productos: \(error.localizedDescription)")
        }
    }

    func cargarProductos() -> [Producto] {
        guard let productosData = userDefaults.data(forKey: productosKey) else { return [] }

        do {
            let productos = try JSONDecoder().decode([Producto].self, from: productosData)
            return productos
        } catch {
            print("Error al decodificar los productos: \(error.localizedDescription)")
            return []
        }
    }
}
