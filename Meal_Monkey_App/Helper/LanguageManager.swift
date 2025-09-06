//import Foundation
//
//class LanguageManager {
//    static let shared = LanguageManager()
//
//    func setLanguage(_ languageCode: String) {
//        UserDefaults.standard.set([languageCode], forKey: "AppleLanguages")
//        UserDefaults.standard.synchronize()
//    }
//
//    func currentLanguage() -> String {
//        let languages = UserDefaults.standard.stringArray(forKey: "AppleLanguages") ?? ["en"]
//        return languages.first ?? "en"
//    }
//
//    func localizedString(for key: String) -> String {
//        let path = Bundle.main.path(forResource: currentLanguage(), ofType: "lproj") ?? ""
//        let bundle = Bundle(path: path) ?? .main
//        return NSLocalizedString(key, tableName: nil, bundle: bundle, value: "", comment: "")
//    }
//}

import Foundation

class LanguageManager {
    static let shared = LanguageManager()
    private init() {}

    private let selectedLanguageKey = "SelectedLanguage"

    var currentLanguage: AppLanguage {
        get {
            if let code = UserDefaults.standard.string(
                forKey: selectedLanguageKey
            ),
                let lang = AppLanguage(rawValue: code)
            {
                return lang
            }
            return .english
        }
        set {
            UserDefaults.standard.setValue(
                newValue.rawValue,
                forKey: selectedLanguageKey
            )
        }
    }

    func localizedString(for key: String) -> String {
        guard
            let path = Bundle.main.path(
                forResource: currentLanguage.rawValue,
                ofType: "lproj"
            ),
            let bundle = Bundle(path: path)
        else {
            return key
        }
        return NSLocalizedString(
            key,
            tableName: nil,
            bundle: bundle,
            value: "",
            comment: ""
        )
    }
}

enum AppLanguage: String, CaseIterable {
    case english = "en"
    case gujarati = "gu"

    var displayName: String {
        switch self {
        case .english: return "English"
        case .gujarati: return "ગુજરાતી"
        }
    }
}
