//
//  AddProductoView.swift
//  Contador de Cuotas
//
//  Created by Mateo Fernandez on 05/12/2023.
//
import SwiftUI

import Foundation
//import DataManager

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
                        .keyboardType(.numberPad)
                }

                Section(header: Text("Información de la Tarjeta")) {
                    TextField("Nombre de la tarjeta", text: $nombreTarjeta)
                }

                Section {
                    Button("Guardar Producto") {
                        viewModel.agregarProducto(nombre: nombreProducto,
                                                  cuotasRestantes: Int(cuotasRestantes) ?? 0,
                                                  precioPorCuota: Int(precioPorCuota) ?? 0,
                                                  nombreTarjeta: nombreTarjeta)
                        isPresented = false
                    }
                }
            }
            .navigationTitle("Nuevo Producto")
        }
    }
    
}


