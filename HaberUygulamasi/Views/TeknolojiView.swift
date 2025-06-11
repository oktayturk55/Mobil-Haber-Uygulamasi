import SwiftUI

struct TeknolojiView: View {
    @StateObject var viewModel = NewsViewModel()

    var body: some View {
        List(viewModel.articles) { article in
            NavigationLink(destination: HaberDetayView(article: article)) {
                Text(article.title)
            }
        }
        .navigationTitle("Teknoloji")
        .onAppear {
            viewModel.fetchNews(category: "technology")
        }
    }
}
