import Foundation

struct Article: Identifiable, Codable, Equatable {
    let uuid = UUID()
    var id: UUID { uuid }
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    var isBookmarked: Bool? = false

    static func == (lhs: Article, rhs: Article) -> Bool {
        return lhs.url == rhs.url
    }
}

struct NewsResponse: Codable {
    let articles: [Article]
}
