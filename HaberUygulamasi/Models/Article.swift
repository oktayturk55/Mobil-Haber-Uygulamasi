import Foundation

struct Article: Identifiable, Codable {
    let uuid = UUID()
    var id: UUID { uuid }
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    var isBookmarked: Bool? = false
}

struct NewsResponse: Codable {
    let articles: [Article]
}
