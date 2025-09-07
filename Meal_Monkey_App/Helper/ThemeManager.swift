import UIKit

class ThemeManager {
    static let shared = ThemeManager()

    enum Theme: String, CaseIterable {
        case light = "Light"
        case dark = "Dark"
        case AccentColor = "AccentColor"
    }

    private(set) var currentTheme: Theme = .light

    func setTheme(_ theme: Theme) {
        currentTheme = theme
        UserDefaults.standard.set(theme.rawValue, forKey: "AppTheme")
    }

    func loadSavedTheme() {
        let saved =
            UserDefaults.standard.string(forKey: "AppTheme")
            ?? Theme.light.rawValue
        currentTheme = Theme(rawValue: saved) ?? .light
    }

    // MARK: - Colors for each theme
    func backgroundColor() -> UIColor {
        switch currentTheme {
        case .light: return .white
        case .dark: return .black
        case .AccentColor: return UIColor(named: "Accent Color")!
        }
    }

    func primaryButtonBackground() -> UIColor {
        switch currentTheme {
        case .light: return UIColor(named: "loginbtnbg")!
        case .dark: return .darkGray
        case .AccentColor: return UIColor(hex: "#6C63FF")// Royal purpal
        }
    }

    func facebookButtonBackground() -> UIColor {
        switch currentTheme {
        case .light: return UIColor(named: "Facebookbtncolor")!
        case .dark: return .darkGray
        case .AccentColor: return UIColor(hex: "#6C63FF")
        }
    }

    func googleButtonBackground() -> UIColor {
        switch currentTheme {
        case .light: return UIColor(named: "googleplusbtncolor")!
        case .dark: return .darkGray
        case .AccentColor: return UIColor(hex: "#6C63FF")
        }
    }

    func buttonTextColor() -> UIColor {
        switch currentTheme {
        case .light, .dark, .AccentColor: return .white
        }
    }
    
    func ratingPointsColor() -> UIColor {
        switch currentTheme {
        case .light: return UIColor(named: "loginbtnbg")!
        case .dark: return .darkGray
        case .AccentColor: return UIColor(named: "lightgrey")!
        }
    }

    func textColor() -> UIColor {
        switch currentTheme {
        case .light: return UIColor(named: "loginsignupcolor")!
        case .dark: return .white
        case .AccentColor: return UIColor(hex: "#1F1F2E")  // Dark Navy
        }
    }
    
    func subTextColor() -> UIColor {
        switch currentTheme {
        case .light: return UIColor(named: "secondarylabelcolor")!
        case .dark: return .white
        case .AccentColor: return UIColor(hex: "#1F1F2E")  
        }
    }

    func accentColor() -> UIColor {
        switch currentTheme {
        case .light: return .systemGreen
        case .dark: return .systemYellow
        case .AccentColor: return UIColor(hex: "#FF6B81")  // Pink Coral
        }
    }
}

// MARK: - Helper for HEX colors
extension UIColor {
    convenience init(hex: String) {
        var hexString: String = hex.trimmingCharacters(
            in: .whitespacesAndNewlines
        ).uppercased()

        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }

        var rgbValue: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgbValue)

        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
