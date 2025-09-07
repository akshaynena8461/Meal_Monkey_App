import UIKit

class ThemeManager {
    static let shared = ThemeManager()

    enum Theme: String, CaseIterable {
        case light = "Light"
        case dark = "Dark"
        case AccentColor = "AccentColor"
        case teal = "Teal"
        case amber = "Amber"
        case mint = "Mint"
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
        case .teal: return UIColor(hex: "#E6FFFA")  // Soft teal background
        case .amber: return UIColor(hex: "#FFF8E1")  // Warm amber background
        case .mint: return UIColor(hex: "#F0FFF4")
        }
    }

    func primaryButtonBackground() -> UIColor {
        switch currentTheme {
        case .light: return UIColor(named: "loginbtnbg")!
        case .dark: return .darkGray
        case .AccentColor: return UIColor(hex: "#6C63FF")  // Royal purpal
        case .teal: return UIColor(hex: "#14B8A6")  // Teal 500
        case .amber: return UIColor(hex: "#FFB300")  // Amber
        case .mint: return UIColor(hex: "#38A169")
        }
    }

    func facebookButtonBackground() -> UIColor {
        switch currentTheme {
        case .light: return UIColor(named: "Facebookbtncolor")!
        case .dark: return .darkGray
        case .AccentColor: return UIColor(hex: "#6C63FF")
        case .teal: return UIColor(hex: "#0D9488")
        case .amber: return UIColor(hex: "#FF8F00")
        case .mint: return UIColor(hex: "#2F855A")
        }
    }

    func googleButtonBackground() -> UIColor {
        switch currentTheme {
        case .light: return UIColor(named: "googleplusbtncolor")!
        case .dark: return .darkGray
        case .AccentColor: return UIColor(hex: "#6C63FF")
        case .teal: return UIColor(hex: "#0D9488")
        case .amber: return UIColor(hex: "#FF8F00")
        case .mint: return UIColor(hex: "#2F855A")
        }
    }

    func buttonTextColor() -> UIColor {
        return .white

    }

    func ratingPointsColor() -> UIColor {
        switch currentTheme {
        case .light: return UIColor(named: "loginbtnbg")!
        case .dark: return .darkGray
        case .AccentColor: return UIColor(named: "lightgrey")!
        case .teal: return UIColor(hex: "#5EEAD4")  // Light teal
        case .amber: return UIColor(hex: "#FFE082")  // Light amber
        case .mint: return UIColor(hex: "#9AE6B4")  // Light mint
        }
    }

    func textColor() -> UIColor {
        switch currentTheme {
        case .light: return UIColor(named: "loginsignupcolor")!
        case .dark: return .white
        case .AccentColor: return UIColor(hex: "#1F1F2E")  // Dark Navy
        case .teal: return UIColor(hex: "#134E4A")  // Deep teal
        case .amber: return UIColor(hex: "#5D4037")  // Brownish for amber
        case .mint: return UIColor(hex: "#22543D")
        }
    }

    func subTextColor() -> UIColor {
        switch currentTheme {
        case .light: return UIColor(named: "secondarylabelcolor")!
        case .dark: return .white
        case .AccentColor: return UIColor(hex: "#1F1F2E")
        case .teal: return UIColor(hex: "#115E59")
        case .amber: return UIColor(hex: "#6D4C41")
        case .mint: return UIColor(hex: "#276749")
        }
    }

    func accentColor() -> UIColor {
        switch currentTheme {
        case .light: return .systemGreen
        case .dark: return .systemYellow
        case .AccentColor: return UIColor(hex: "#FF6B81")  // Pink Coral
        case .teal: return UIColor(hex: "#06B6D4")  // Cyan accent
        case .amber: return UIColor(hex: "#FF7043")  // Coral-ish accent
        case .mint: return UIColor(hex: "#68D391")  // Mint accent
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
