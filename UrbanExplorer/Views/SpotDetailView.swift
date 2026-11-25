import SwiftUI

struct SpotDetailView: View {
    let spot: Spot

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(spot.category.rawValue.uppercased())
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundStyle(.tint)

                        Spacer()

                        Label(String(format: "%.1f", spot.rating), systemImage: "star.fill")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.orange)
                    }

                    Text(spot.title)
                        .font(.title2)
                        .fontWeight(.bold)

                    Text(spot.description)
                        .font(.body)
                        .foregroundStyle(.secondary)
                }

                Divider()

                VStack(alignment: .leading, spacing: 10) {
                    Text("Información del lugar")
                        .font(.headline)

                    Label(
                        "Añadido el \(spot.createdAt.formatted(date: .long, time: .omitted))",
                        systemImage: "calendar"
                    )
                    .font(.subheadline)

                    Label(
                        String(format: "Coordenadas: %.4f, %.4f", spot.latitude, spot.longitude),
                        systemImage: "mappin.and.ellipse"
                    )
                    .font(.subheadline)

                    Label(
                        "\(spot.visitCount.formatted()) visitas registradas",
                        systemImage: "person.2.fill"
                    )
                    .font(.subheadline)

                    Link(destination: spot.webURL) {
                        Label("Visitar web oficial", systemImage: "safari")
                            .font(.subheadline)
                            .fontWeight(.medium)
                    }
                    .padding(.top, 4)
                }

                if !spot.tags.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Etiquetas")
                            .font(.headline)

                        HStack(spacing: 8) {
                            ForEach(spot.tags, id: \.self) { tag in
                                Text("#\(tag)")
                                    .font(.caption)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 5)
                                    .background(Color.accentColor.opacity(0.12), in: Capsule())
                            }
                        }
                    }
                }

                if !spot.reviews.isEmpty {
                    Divider()

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Reseñas (\(spot.reviews.count))")
                            .font(.headline)

                        ForEach(spot.reviews) { review in
                            VStack(alignment: .leading, spacing: 6) {
                                HStack {
                                    Text(review.autor)
                                        .font(.subheadline)
                                        .fontWeight(.semibold)

                                    Spacer()

                                    HStack(spacing: 2) {
                                        ForEach(1...5, id: \.self) { index in
                                            Image(systemName: index <= review.points ? "star.fill" : "star")
                                                .font(.caption2)
                                                .foregroundStyle(.orange)
                                        }
                                    }
                                }

                                Text(review.comment)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)

                                Text(review.date.formatted(date: .abbreviated, time: .omitted))
                                    .font(.caption2)
                                    .foregroundStyle(.tertiary)
                            }
                            .padding()
                            .background(Color.secondary.opacity(0.08), in: RoundedRectangle(cornerRadius: 12))
                        }
                    }
                }
            }
            .padding()
        }
        .navigationTitle(spot.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}