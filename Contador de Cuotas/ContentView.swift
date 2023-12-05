//
//  ContentView.swift
//  Contador de Cuotas
//
//  Created by Mateo Fernandez on 05/12/2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = MainViewModel()
    @State private var showingAddProductoView = false

    var totalPorMes: Double {
        viewModel.calcularTotalPorMes()
    }

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List {
                    ForEach(viewModel.productos) { producto in
                        Section(header: Text(producto.nombreTarjeta)) {
                            VStack(alignment: .leading) {
                                Text(producto.nombre)
                                    .font(.headline)
                                Text("Cuotas restantes: \(producto.cuotasRestantes)")
                                Text("Precio por cuota: \(producto.precioPorCuota)")
                            }
                        }
                    }
                }.id(UUID())
                .navigationTitle("Productos")
                .navigationBarItems(trailing:
                    Button(action: {
                        showingAddProductoView.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                )

                Spacer()

                HStack {
                    Text("Total a pagar este mes: ")
                        .font(.headline)
                    Text("\(totalPorMes, specifier: "%.2f")")
                        .foregroundColor(.blue)
                        .font(.headline)
                    Button(action: {
                        restarCuotas()
                    }) {
                        Text("Restar 1 a todas las cuotas")
                            .foregroundColor(.red)
                    }
                }
                .padding()
            }
            .sheet(isPresented: $showingAddProductoView) {
                AddProductoView(viewModel: viewModel, isPresented: $showingAddProductoView)
            }
        }
    }

    func restarCuotas() {
        // Restar 1 a todas las cuotas restantes y eliminar productos sin cuotas restantes
        viewModel.actualizarCuotas()
    }
}
