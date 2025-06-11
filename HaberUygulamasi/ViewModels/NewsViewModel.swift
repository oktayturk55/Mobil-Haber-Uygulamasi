import Foundation

class NewsViewModel: ObservableObject {
    @Published var articles: [Article] = []
    
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
                    }
                } catch {
                    print("JSON çözümleme hatası: \(error)")
                }
            }
        }.resume()
    }
}
