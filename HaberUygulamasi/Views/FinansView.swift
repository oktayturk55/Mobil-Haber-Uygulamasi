import SwiftUI

struct FinansView: View {
    @StateObject var viewModel = NewsViewModel()

    var body: some View {
        List(viewModel.articles) { article in
            NavigationLink(destination: HaberDetayView(article: article)) {
                Text(article.title)
            }
        }
        .navigationTitle("Finans")
        .onAppear {
            viewModel.fetchNews(category: "business")
        }
    }
}
