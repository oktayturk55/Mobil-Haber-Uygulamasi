import SwiftUI

struct AnaSayfaView: View {
    @StateObject var viewModel = NewsViewModel()
    @State private var currentIndex = 0
    let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()

    var gorselliHaberler: [Article] {
        viewModel.articles.filter { $0.urlToImage != nil }
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        NavigationLink(destination: GundemView()) { kategoriButonu("Gündem") }
                        NavigationLink(destination: TeknolojiView()) { kategoriButonu("Teknoloji") }
                        NavigationLink(destination: SporView()) { kategoriButonu("Spor") }
                        NavigationLink(destination: FinansView()) { kategoriButonu("Finans") }
                    }.padding(.horizontal)
                }

                if !gorselliHaberler.isEmpty {
                    TabView(selection: $currentIndex) {
                        ForEach(Array(gorselliHaberler.prefix(5).enumerated()), id: \.offset) { index, article in
                            ZStack(alignment: .bottomLeading) {
                                if let imageUrl = article.urlToImage, let url = URL(string: imageUrl) {
                                    AsyncImage(url: url) { image in
                                        image.resizable().aspectRatio(contentMode: .fill)
                                            .frame(height: 220).clipped()
                                    } placeholder: { ProgressView() }
                                }
                                Text(article.title)
                                    .font(.caption).foregroundColor(.white)
                                    .padding(8).background(Color.black.opacity(0.6))
                            }
                            .cornerRadius(10).padding(.horizontal)
                            .tag(index)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle())
                    .frame(height: 240)
                    .onReceive(timer) { _ in
                        withAnimation {
                            currentIndex = (currentIndex + 1) % max(gorselliHaberler.prefix(5).count, 1)
                        }
                    }
                }

                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(gorselliHaberler) { article in
                            NavigationLink(destination: HaberDetayView(article: article)) {
                                HStack(alignment: .top, spacing: 10) {
                                    VStack(alignment: .leading, spacing: 6) {
                                        Text(article.title).font(.headline).foregroundColor(.primary)
                                        Text(article.description?.prefix(50) ?? "") + Text("...")
                                            .font(.subheadline).foregroundColor(.secondary)
                                    }
                                    Spacer()
                                    if let imageUrl = article.urlToImage, let url = URL(string: imageUrl) {
                                        AsyncImage(url: url) { image in
                                            image.resizable().aspectRatio(contentMode: .fill)
                                                .frame(width: 100, height: 80).clipped().cornerRadius(6)
                                        } placeholder: { ProgressView() }
                                    }
                                }
                                .padding().background(Color.gray.opacity(0.1))
                                .cornerRadius(10).padding(.horizontal)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Haberler")
        }
        .onAppear { viewModel.fetchNews() }
    }

    private func kategoriButonu(_ ad: String) -> some View {
        Text(ad).font(.subheadline)
            .padding(.horizontal, 12).padding(.vertical, 8)
            .background(Color.blue.opacity(0.2)).cornerRadius(10)
    }
}
