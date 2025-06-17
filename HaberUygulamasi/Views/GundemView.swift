import SwiftUI

struct GundemView: View {
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
        .navigationTitle("Gündem")
        .onAppear {
            viewModel.fetchNews(category: "general")
        }
    }
}
