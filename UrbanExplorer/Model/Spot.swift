import Foundation

enum SpotCategory: String, Codable, Hashable, CaseIterable {
    case monumento = "Monumento"
    case parque = "Parque"
    case restaurante = "Restaurante"
    case museo = "Museo"
}

struct Spot: Codable, Identifiable, Hashable {
    let id: UUID
    let title: String
    let description: String
    let category: SpotCategory
    let rating: Double
    let visitCount: Int
    var isFavorite: Bool
    let createdAt: Date
    let tags: [String]
    let imageURL: [URL]
    let mainImageURL: URL
    let webURL: URL
    let latitude: Double
    let longitude: Double
    let reviews: [Review]

    enum CodingKeys: String, CodingKey {
        case id, title, description, category, rating, visitCount
        case isFavorite, createdAt, tags, imageURL, mainImageURL
        case webURL, latitude, longitude, reviews
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.description = try container.decode(String.self, forKey: .description)
        self.category = try container.decode(SpotCategory.self, forKey: .category)

        let decodedRating = try container.decode(Double.self, forKey: .rating)
        guard (1.0...5.0).contains(decodedRating) else {
            throw DecodingError.dataCorruptedError(
                forKey: .rating,
                in: container,
                debugDescription: "El rating (\(decodedRating)) debe estar entre 1.0 y 5.0."
            )
        }
        self.rating = decodedRating

        let decodedVisits = try container.decode(Int.self, forKey: .visitCount)
        guard decodedVisits >= 0 else {
            throw DecodingError.dataCorruptedError(
                forKey: .visitCount,
                in: container,
                debugDescription: "El número de visitas no puede ser negativo."
            )
        }
        self.visitCount = decodedVisits

        self.isFavorite = try container.decode(Bool.self, forKey: .isFavorite)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.tags = try container.decode([String].self, forKey: .tags)

        let decodedImages = try container.decode([URL].self, forKey: .imageURL)
        guard !decodedImages.isEmpty else {
            throw DecodingError.dataCorruptedError(
                forKey: .imageURL,
                in: container,
                debugDescription: "imageURL debe contener al menos una imagen."
            )
        }
        self.imageURL = decodedImages

        self.mainImageURL = try container.decode(URL.self, forKey: .mainImageURL)
        self.webURL = try container.decode(URL.self, forKey: .webURL)

        let decodedLat = try container.decode(Double.self, forKey: .latitude)
        guard (-90.0...90.0).contains(decodedLat) else {
            throw DecodingError.dataCorruptedError(
                forKey: .latitude,
                in: container,
                debugDescription: "Latitud fuera de rango (-90...90)."
            )
        }
        self.latitude = decodedLat

        let decodedLon = try container.decode(Double.self, forKey: .longitude)
        guard (-180.0...180.0).contains(decodedLon) else {
            throw DecodingError.dataCorruptedError(
                forKey: .longitude,
                in: container,
                debugDescription: "Longitud fuera de rango (-180...180)."
            )
        }
        self.longitude = decodedLon

        self.reviews = try container.decode([Review].self, forKey: .reviews)
    }
}