import Foundation

class AppSettings {
    static var language: String {
        UserDefaults.standard.string(forKey: "selectedLanguage") ?? "tr"
    }

    static var country: String {
        UserDefaults.standard.string(forKey: "selectedCountry") ?? "tr"
    }
}
