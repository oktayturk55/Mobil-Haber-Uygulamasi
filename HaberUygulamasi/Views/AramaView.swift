import SwiftUI

struct AramaView: View {
    @StateObject var viewModel = NewsViewModel()
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            VStack {
                TextField("Haber ara...", text: $searchText)
                    .padding().background(Color.gray.opacity(0.2))
                    .cornerRadius(8).padding()

                List(viewModel.articles.filter {
                    searchText.isEmpty ? true : $0.title.lowercased().contains(searchText.lowercased())
                }) { article in
                    NavigationLink(destination: HaberDetayView(article: article)) {
                        Text(article.title)
                    }
                }
            }
            .navigationTitle("Arama")
        }
        .onAppear { viewModel.fetchNews() }
    }
}
