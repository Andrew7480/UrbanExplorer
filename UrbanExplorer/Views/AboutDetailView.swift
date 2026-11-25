import SwiftUI

struct AboutDetailView: View {
    var body: some View {
        VStack(spacing: 24) {
            Spacer()

            Image(systemName: "map.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 96, height: 96)
                .foregroundStyle(.tint)

            VStack(spacing: 8) {
                Text("UrbanExplorer")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("Guía de Puntos de Interés")
                    .font(.headline)
                    .foregroundStyle(.secondary)
            }

            VStack(spacing: 12) {
                Text("Aplicación desarrollada en SwiftUI para la asignatura Aplicaciones para Dispositivos Móviles.")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)

                Divider()
                    .padding(.horizontal, 32)

                VStack(spacing: 4) {
                    Text("Desarrollado por")
                        .font(.caption)
                        .foregroundStyle(.tertiary)

                    Text("Andres Cardozo")
                        .font(.headline)
                }
            }
            .padding()
            .background(Color.secondary.opacity(0.08), in: RoundedRectangle(cornerRadius: 16))
            .padding(.horizontal)

            Spacer()

            Text("Entregable Parcial 1 • Swift 6")
                .font(.caption2)
                .foregroundStyle(.tertiary)
        }
        .padding()
        .navigationTitle("Acerca de")
        .navigationBarTitleDisplayMode(.inline)
    }
}