import Foundation
import UIKit

/// Utility class to apply custom UI styles (borders, paddings, etc.)
class EditStyle {

    /// Applies border and corner radius to an array of textfields or UIViews
    /// - Parameters:
    ///   - textfields: Array of UIViews (usually UITextFields)
    ///   - cornerRadious: The radius for rounded corners
    class func setborder(textfields: [UIView], cornerRadious: CGFloat) {
        for textField in textfields {
            textField.layer.borderColor = UIColor.lightGray.cgColor
            textField.layer.cornerRadius = cornerRadious
            textField.clipsToBounds = false
        }
    }

    /// Adds left & right padding inside UITextFields
    /// - Parameters:
    ///   - textFields: Array of UIViews (will only apply if UIView is UITextField)
    ///   - paddingWidth: The width of padding space
    class func setPadding(textFields: [UIView], paddingWidth: CGFloat) {
        for view in textFields {
            if let textField = view as? UITextField {
                let paddingView = UIView(
                    frame: CGRect(
                        x: 0,
                        y: 0,
                        width: paddingWidth,
                        height: textField.frame.height
                    )
                )
                textField.leftView = paddingView
                textField.leftViewMode = .always
                textField.rightView = paddingView
                textField.rightViewMode = .always
            }
        }
    }

    /// Applies border style specifically for OTP textfields
    /// - Parameter textfields: Array of UIViews (typically UITextFields for OTP input)
    class func setOTPtextFieldborder(textfields: [UIView]) {
        for textField in textfields {
            textField.layer.borderColor = UIColor.lightGray.cgColor
            textField.layer.cornerRadius = 12
            textField.clipsToBounds = false
        }
    }

    /// Adds rounded border styling to stack views
    /// - Parameter stackViews: Array of stack views to style
    class func addStackBorder(stackViews: [UIView]) {
        for stackView in stackViews {
            stackView.layer.cornerRadius = 28
            stackView.layer.borderColor = UIColor.lightGray.cgColor
            stackView.clipsToBounds = true
        }
    }
}

// MARK: - UIViewController Navigation Extensions
extension UIViewController {

    /// Sets a custom left navigation item with a back button and title (used for general screens like Login/Signup)
    /// - Parameters:
    ///   - title: Navigation title text
    ///   - font: Custom font (default: system font size 29)
    ///   - textColor: Title and icon color (default: custom color or black)
    ///   - target: Target for back button action
    ///   - action: Selector for back button tap
    func setLeftAlignedTitleWithBack(
        _ title: String,
        font: UIFont = .systemFont(ofSize: 29),
        textColor: UIColor = UIColor(named: "loginsignupcolor") ?? .black,
        target: Any?,
        action: Selector
    ) {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.setTitle("  \(title)", for: .normal)
        button.setTitleColor(textColor, for: .normal)
        button.titleLabel?.font = font
        button.tintColor = textColor
        button.addTarget(target, action: action, for: .touchUpInside)
        button.sizeToFit()

        let leftItem = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = leftItem
    }

    /// Sets a custom left navigation item for **Product Detail Page** (separate color theme)
    func setLeftAlignedTitleWithBackInProductDetailPage(
        _ title: String,
        font: UIFont = .systemFont(ofSize: 29),
        textColor: UIColor = UIColor(named: "Color") ?? .black,
        target: Any?,
        action: Selector
    ) {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.setTitle("  \(title)", for: .normal)
        button.setTitleColor(textColor, for: .normal)
        button.titleLabel?.font = font
        button.tintColor = textColor
        button.addTarget(target, action: action, for: .touchUpInside)
        button.sizeToFit()

        let leftItem = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = leftItem
    }

    /// Sets a plain title label in navigation bar (without back button)
    /// - Parameters:
    ///   - title: Title string
    ///   - font: Custom font (default: system font size 29)
    ///   - textColor: Text color (default: custom NavigationColor or black)
    func setLeftAlignedTitle(
        _ title: String,
        font: UIFont = .systemFont(ofSize: 29),
        textColor: UIColor = UIColor(named: "NavigationColor") ?? .black
    ) {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = font
        titleLabel.textColor = textColor
        titleLabel.sizeToFit()

        let leftItem = UIBarButtonItem(customView: titleLabel)
        self.navigationItem.leftBarButtonItem = leftItem
    }

    /// Adds a cart button on the right side of navigation bar (used in general screens)
    func setCartButton(
        target: Any?,
        action: Selector,
        tintColor: UIColor = UIColor(named: "NavigationColor") ?? .black
    ) {
        // Create button
        let count = CartManager.shared.count
        print("count : \(count)")
        let button = UIButton(type: .custom)
        let cartImage = UIImage(systemName: "cart.fill")?.withRenderingMode(
            .alwaysTemplate
        )
        button.setImage(cartImage, for: .normal)
        button.tintColor = tintColor
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.addTarget(target, action: action, for: .touchUpInside)

        // Remove old badge if already present
        button.subviews.forEach {
            if $0.tag == 999 { $0.removeFromSuperview() }
        }

        // Add badge only if count > 0
        if count > 0 {
            let badgeLabel = UILabel()
            badgeLabel.tag = 999
            badgeLabel.text = "\(count)"
            badgeLabel.textColor = .white
            badgeLabel.font = UIFont.systemFont(ofSize: 11, weight: .bold)
            badgeLabel.textAlignment = .center
            badgeLabel.backgroundColor = .red
            badgeLabel.layer.cornerRadius = 10
            badgeLabel.clipsToBounds = true

            // Set badge frame (positioned top-right)
            let badgeSize: CGFloat = 20
            badgeLabel.frame = CGRect(
                x: button.frame.width - badgeSize / 2 - 4,
                y: -5,
                width: badgeSize,
                height: badgeSize
            )

            button.addSubview(badgeLabel)
        }

        // Add to navigation item
        let cartBarButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = cartBarButton
    }

    /// Adds a cart button on the right side of navigation bar (for Product Detail Page theme)
    func setCartButtonInProductDetail(
        target: Any?,
        action: Selector,
        tintColor: UIColor = UIColor(named: "Color") ?? .white
    ) {
        let count = CartManager.shared.count

        let button = UIButton(type: .custom)
        let cartImage = UIImage(systemName: "cart.fill")?.withRenderingMode(
            .alwaysTemplate
        )
        button.setImage(cartImage, for: .normal)
        button.tintColor = tintColor
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.addTarget(target, action: action, for: .touchUpInside)

        // remove old badge
        button.subviews.forEach {
            if $0.tag == 999 { $0.removeFromSuperview() }
        }

        if count > 0 {
            let badgeLabel = UILabel()
            badgeLabel.tag = 999
            badgeLabel.text = "\(count)"
            badgeLabel.textColor = .white
            badgeLabel.font = UIFont.systemFont(ofSize: 11, weight: .bold)
            badgeLabel.textAlignment = .center
            badgeLabel.backgroundColor = .red
            badgeLabel.layer.cornerRadius = 10
            badgeLabel.clipsToBounds = true

            let badgeSize: CGFloat = 20
            badgeLabel.frame = CGRect(
                x: button.frame.width - badgeSize / 2 - 4,
                y: -5,
                width: badgeSize,
                height: badgeSize
            )

            button.addSubview(badgeLabel)
        }

        let cartBarButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = cartBarButton
    }

}
