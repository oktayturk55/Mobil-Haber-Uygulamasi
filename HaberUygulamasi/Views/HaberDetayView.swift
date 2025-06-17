import SwiftUI
import UIKit

struct HaberDetayView: View {
    let article: Article
    @State private var isBookmarked = false
    @Environment(\.openURL) var openURL
    @StateObject var viewModel = NewsViewModel()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let imageUrl = article.urlToImage, let url = URL(string: imageUrl) {
                    AsyncImage(url: url) { image in
                        image.resizable().aspectRatio(contentMode: .fit)
                    } placeholder: { ProgressView() }
                    .frame(maxWidth: .infinity)
                }

                Text(article.title).font(.title2).foregroundColor(.primary)
                Text(article.description ?? "Detay bulunamadı").foregroundColor(.secondary)

                HStack {
                    Button(action: {
                        viewModel.toggleBookmark(for: article)
                        isBookmarked.toggle()
                        viewModel.sendLocalNotification(title: "Favoriye Eklendi", body: article.title)
                    }) {
                        HStack {
                            Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                            Text(isBookmarked ? "Kaydedildi" : "Kaydet")
                        }
                        .padding().foregroundColor(.white)
                        .background(Color.blue).cornerRadius(8)
                    }

                    Spacer()

                    Button(action: {
                        shareArticle(url: article.url)
                    }) {
                        HStack {
                            Image(systemName: "square.and.arrow.up")
                            Text("Paylaş")
                        }
                        .padding().foregroundColor(.white)
                        .background(Color.green).cornerRadius(8)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Detay")
    }

    private func shareArticle(url: String) {
        guard let shareURL = URL(string: url) else { return }
        let av = UIActivityViewController(activityItems: [shareURL], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
    }
}
