//
//  AddProductoView.swift
//  Contador de Cuotas
//
//  Created by Mateo Fernandez on 05/12/2023.
//
import SwiftUI

import Foundation

struct AddProductoView: View {
    @ObservedObject var viewModel: MainViewModel
    @Binding var isPresented: Bool
    @State private var nombreProducto = ""
    @State private var cuotasRestantes = ""
    @State private var precioPorCuota = ""
    @State private var nombreTarjeta = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Información del Producto")) {
                    TextField("Nombre del producto", text: $nombreProducto)
                    TextField("Cuotas Restantes", text: $cuotasRestantes)
                        .keyboardType(.numberPad)
                    TextField("Precio por Cuota", text: $precioPorCuota)
                        .keyboardType(.decimalPad)
                }

                Section(header: Text("Información de la Tarjeta")) {
                    TextField("Nombre de la tarjeta", text: $nombreTarjeta)
                }

                Section {
                    Button("Guardar Producto") {
                        viewModel.agregarProducto(nombre: nombreProducto,
                                                  cuotasRestantes: Int(cuotasRestantes) ?? 0,
                                                  precioPorCuota: (Double(precioPorCuota) ?? 0.0).rounded(toPlaces: 2),
                                                  nombreTarjeta: nombreTarjeta)
                        isPresented = false
                    }
                }
            }
            .navigationTitle("Nuevo Producto")
        }
    }
    
}

extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

