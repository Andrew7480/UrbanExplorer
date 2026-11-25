import Foundation

struct Spot: Codable, Identifiable, Hashable {
    let id: UUID
    let title: String
    let description: String
    let category: String
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
}