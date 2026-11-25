import Foundation

struct Review: Codable, Identifiable, Hashable {
    let id: UUID
    let autor: String
    let date: Date
    let comment: String
    let points: Int

    enum CodingKeys: String, CodingKey {
        case autor
        case date
        case comment
        case points
    }

    init(
        id: UUID = UUID(),
        autor: String,
        date: Date,
        comment: String,
        points: Int
    ) {
        self.id = id
        self.autor = autor
        self.date = date
        self.comment = comment
        self.points = points
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = UUID()
        self.autor = try container.decode(String.self, forKey: .autor)
        self.date = try container.decode(Date.self, forKey: .date)
        self.comment = try container.decode(String.self, forKey: .comment)
        self.points = try container.decode(Int.self, forKey: .points)
    }
}