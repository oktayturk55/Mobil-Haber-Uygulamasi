import SwiftUI

struct AramaView: View {
    @StateObject var viewModel = NewsViewModel()
    @State private var searchText = ""

    var filteredArticles: [Article] {
        if searchText.isEmpty {
            return viewModel.articles
        } else {
            return viewModel.articles.filter {
                $0.title.lowercased().contains(searchText.lowercased()) ||
                ($0.description?.lowercased().contains(searchText.lowercased()) ?? false)
            }
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                TextField("Haber ara...", text: $searchText)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .padding()

                List(filteredArticles) { article in
                    NavigationLink(destination: HaberDetayView(article: article)) {
                        VStack(alignment: .leading) {
                            Text(article.title).font(.headline)
                            Text(article.description ?? "").font(.subheadline).foregroundColor(.secondary)
                        }
                    }
                }
            }
            .navigationTitle("Arama")
        }
        .onAppear { viewModel.fetchNews() }
    }
}
