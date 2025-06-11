import SwiftUI

struct AyarlarView: View {
    @AppStorage("isDarkMode") var isDarkMode: Bool = true
    @AppStorage("selectedLanguage") var selectedLanguage: String = "tr"
    @AppStorage("selectedCountry") var selectedCountry: String = "tr"

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Tema")) {
                    Toggle("Karanlık Mod", isOn: $isDarkMode)
                }

                Section(header: Text("Dil")) {
                    Picker("Dil", selection: $selectedLanguage) {
                        Text("Türkçe").tag("tr")
                        Text("İngilizce").tag("en")
                    }.pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text("Ülke")) {
                    Picker("Ülke", selection: $selectedCountry) {
                        Text("Türkiye").tag("tr")
                        Text("Amerika").tag("us")
                        Text("Almanya").tag("de")
                    }
                }
            }
            .navigationTitle("Ayarlar")
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}
