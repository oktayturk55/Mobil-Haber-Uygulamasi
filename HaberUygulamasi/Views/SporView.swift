import SwiftUI

struct SporView: View {
    @StateObject var viewModel = NewsViewModel()

    var body: some View {
        List(viewModel.articles) { article in
            NavigationLink(destination: HaberDetayView(article: article)) {
                Text(article.title)
            }
        }
        .navigationTitle("Spor")
        .onAppear {
            viewModel.fetchNews(category: "sports")
        }
    }
}
