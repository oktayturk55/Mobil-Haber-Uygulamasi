import SwiftUI

struct GundemView: View {
    @StateObject var viewModel = NewsViewModel()

    var body: some View {
        List(viewModel.articles) { article in
            NavigationLink(destination: HaberDetayView(article: article)) {
                Text(article.title)
            }
        }
        .navigationTitle("Gündem")
        .onAppear {
            viewModel.fetchNews(category: "general")
        }
    }
}
