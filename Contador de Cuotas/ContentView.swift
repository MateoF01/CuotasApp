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

    var totalPorMes: Int {
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
                        }.swipeActions {
                            Button("Eliminar", role: .destructive) {
                                viewModel.eliminarProducto(producto: producto)
                            }
                        }
                    }
                }.id(UUID())
                .navigationTitle("CuotApp")
                .navigationBarItems(trailing:
                    Button(action: {
                        showingAddProductoView.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                )

                Spacer()

                HStack {
                    Text("A pagar este mes:")
                        .font(.headline)
                    
                    Spacer()
                    
                    Text("\(totalPorMes)")        
                        .foregroundColor(.blue)
                        .font(.headline)

                    Spacer()
                    
                    Button(action: {
                        restarCuotas()
                    }) {
                        Text("Pagar Mes")
                            .foregroundColor(.red)
                    }
                }
                .padding()
            }.onAppear{
                viewModel.cargarProductos()
            }
            .sheet(isPresented: $showingAddProductoView) {
                AddProductoView(viewModel: viewModel, isPresented: $showingAddProductoView)
            }
        }.onReceive(NotificationCenter.default
            .publisher(for: UIApplication.willResignActiveNotification)) { _ in
            // Este bloque se ejecutará cuando la aplicación esté a punto de pasar a segundo plano o cerrarse
            viewModel.guardarProductos()
        }
    }

    func restarCuotas() {
        // Restar 1 a todas las cuotas restantes y eliminar productos sin cuotas restantes
        viewModel.actualizarCuotas()
    }
}
