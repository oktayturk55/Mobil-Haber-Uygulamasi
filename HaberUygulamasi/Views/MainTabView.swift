import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            AnaSayfaView().tabItem { Label("Ana Sayfa", systemImage: "house") }
            AramaView().tabItem { Label("Arama", systemImage: "magnifyingglass") }
            KaydedilenlerView().tabItem { Label("Kaydedilenler", systemImage: "bookmark") }
            AyarlarView().tabItem { Label("Ayarlar", systemImage: "gear") }
        }
    }
}
