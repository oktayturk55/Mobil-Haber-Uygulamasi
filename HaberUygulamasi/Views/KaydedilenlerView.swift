import SwiftUI

struct KaydedilenlerView: View {
    @StateObject var viewModel = NewsViewModel()

    var body: some View {
        NavigationView {
            VStack(spacing: 12) {
                if viewModel.bookmarkedArticles.isEmpty {
                    Text("Henüz favori haber eklenmemiş.")
                        .font(.headline)
                        .foregroundColor(.secondary)
                        .padding()
                } else {
                    ScrollView {
                        VStack(spacing: 12) {
                            ForEach(viewModel.bookmarkedArticles) { article in
                                NavigationLink(destination: HaberDetayView(article: article)) {
                                    CardView(article: article)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.top)
                    }
                    .background(Color(.systemGroupedBackground))
                }
            }
            .navigationTitle("Kaydedilenler")
        }
    }
}
