import Foundation
import UserNotifications

class NewsViewModel: ObservableObject {
    @Published var articles: [Article] = []
    @Published var bookmarkedArticles: [Article] = [] {
        didSet {
            saveBookmarks()
        }
    }
    @Published var offlineArticles: [Article] = []

    init() {
        loadBookmarks()
        loadLocalArticles()
    }

    func fetchNews(category: String = "general") {
        let language = AppSettings.language
        let country = AppSettings.country
        let urlString = "https://newsapi.org/v2/top-headlines?country=\(country)&category=\(category)&language=\(language)&apiKey=35f7a8af97044948bad15f1d096e1330"

        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(NewsResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.articles = decodedResponse.articles
                        self.saveOfflineArticles()
                    }
                } catch {
                    print("JSON çözümleme hatası: \(error)")
                }
            }
        }.resume()
    }

    func toggleBookmark(for article: Article) {
        if let index = bookmarkedArticles.firstIndex(of: article) {
            bookmarkedArticles.remove(at: index)
        } else {
            bookmarkedArticles.append(article)
        }
    }

    func isBookmarked(_ article: Article) -> Bool {
        bookmarkedArticles.contains(article)
    }

    func loadLocalArticles() {
        if let savedData = UserDefaults.standard.data(forKey: "offlineArticles"),
           let decoded = try? JSONDecoder().decode([Article].self, from: savedData) {
            offlineArticles = decoded
        }
    }

    private func saveOfflineArticles() {
        if let encoded = try? JSONEncoder().encode(articles) {
            UserDefaults.standard.set(encoded, forKey: "offlineArticles")
        }
    }

    private func saveBookmarks() {
        if let encoded = try? JSONEncoder().encode(bookmarkedArticles) {
            UserDefaults.standard.set(encoded, forKey: "bookmarkedArticles")
        }
    }

    private func loadBookmarks() {
        if let savedData = UserDefaults.standard.data(forKey: "bookmarkedArticles"),
           let decoded = try? JSONDecoder().decode([Article].self, from: savedData) {
            bookmarkedArticles = decoded
        }
    }

    func sendLocalNotification(title: String, body: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request)
    }
}

