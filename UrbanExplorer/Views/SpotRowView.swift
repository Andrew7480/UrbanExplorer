import SwiftUI

struct SpotRowView: View {
    let spot: Spot

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: iconoCategoria)
                .font(.title2)
                .foregroundStyle(.white)
                .frame(width: 44, height: 44)
                .background(colorCategoria.gradient, in: RoundedRectangle(cornerRadius: 10))

            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Text(spot.title)
                        .font(.headline)
                        .lineLimit(1)

                    Spacer()

                    if spot.isFavorite {
                        Image(systemName: "heart.fill")
                            .foregroundStyle(.red)
                            .font(.subheadline)
                    }
                }

                HStack(spacing: 8) {
                    Text(spot.category.rawValue)
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundStyle(colorCategoria)

                    Text("•")
                        .foregroundStyle(.secondary)

                    Label(String(format: "%.1f", spot.rating), systemImage: "star.fill")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundStyle(.orange)
                }

                if !spot.tags.isEmpty {
                    HStack(spacing: 6) {
                        ForEach(spot.tags.prefix(3), id: \.self) { tag in
                            Text(tag)
                                .font(.caption2)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 3)
                                .background(Color.secondary.opacity(0.12), in: Capsule())
                        }
                    }
                }
            }
        }
        .padding(.vertical, 4)
    }

    private var iconoCategoria: String {
        switch spot.category {
        case .monumento: return "building.columns.fill"
        case .parque: return "leaf.fill"
        case .restaurante: return "fork.knife"
        case .museo: return "paintpalette.fill"
        }
    }

    private var colorCategoria: Color {
        switch spot.category {
        case .monumento: return .indigo
        case .parque: return .green
        case .restaurante: return .orange
        case .museo: return .purple
        }
    }
}