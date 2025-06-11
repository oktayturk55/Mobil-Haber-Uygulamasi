import SwiftUI

struct HaberDetayView: View {
    let article: Article
    @State private var isBookmarked = false

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

                Button(action: {
                    isBookmarked.toggle()
                }) {
                    HStack {
                        Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                        Text(isBookmarked ? "Kaydedildi" : "Kaydet")
                    }
                    .padding().foregroundColor(.white)
                    .background(Color.blue).cornerRadius(8)
                }
            }
            .padding()
        }
        .navigationTitle("Detay")
    }
}
