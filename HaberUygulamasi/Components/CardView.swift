import SwiftUI

struct CardView: View {
    let article: Article

    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            VStack(alignment: .leading, spacing: 6) {
                Text(article.title)
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .foregroundColor(.primary)

                Text(article.description?.prefix(50) ?? "") + Text("...")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
            if let imageUrl = article.urlToImage, let url = URL(string: imageUrl) {
                AsyncImage(url: url) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 80)
                        .clipped()
                        .cornerRadius(8)
                } placeholder: { ProgressView() }
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(Color.white).shadow(radius: 4))
        .padding(.horizontal)
    }
}
