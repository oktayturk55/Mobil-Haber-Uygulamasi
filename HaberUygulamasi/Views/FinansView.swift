import SwiftUI

struct FinansView: View {
    @StateObject var viewModel = NewsViewModel()

    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                ForEach(viewModel.articles) { article in
                    NavigationLink(destination: HaberDetayView(article: article)) {
                        CardView(article: article)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding(.top)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Finans")
        .onAppear {
            viewModel.fetchNews(category: "business")
        }
    }
}
