import SwiftUI

struct SpotListView: View {
    private let spots: [Spot] = JSONLoader.cargarSpotsSeguro()
    @State private var mostrarAcercaDe = false

    var body: some View {
        NavigationStack {
            List(spots) { spot in
                NavigationLink(value: spot) {
                    SpotRowView(spot: spot)
                }
            }
            .navigationTitle("Urban Explorer")
            .navigationDestination(for: Spot.self) { spot in
                SpotDetailView(spot: spot)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        mostrarAcercaDe = true
                    } label: {
                        Label("Acerca de", systemImage: "info.circle")
                    }
                }
            }
            .sheet(isPresented: $mostrarAcercaDe) {
                NavigationStack {
                    AboutDetailView()
                }
            }
        }
    }
}

#Preview {
    SpotListView()
}