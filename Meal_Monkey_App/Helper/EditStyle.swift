import Foundation
import UIKit

class EditStyle {
    class func setborder(textfields: [UIView],cornerRadious:CGFloat) {
        for textField in textfields {
            textField.layer.borderColor = UIColor.lightGray.cgColor
            textField.layer.cornerRadius = cornerRadious
            textField.clipsToBounds = false
        }

    }

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
            }
        }
    }
    class func setOTPtextFieldborder(textfields: [UIView]) {
        for textField in textfields {
            textField.layer.borderColor = UIColor.lightGray.cgColor
            textField.layer.cornerRadius = 12
            textField.clipsToBounds = false
        }

    }
     
    class func addStackBorder(stackViews: [UIView]) {
        for stackView in stackViews {
            stackView.layer.cornerRadius = 28
            stackView.layer.borderColor = UIColor.lightGray.cgColor
            stackView.clipsToBounds = true
        }
    }

}

extension UIViewController {

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

    func setCartButton(
        target: Any?,
        action: Selector,
        tintColor: UIColor = UIColor(named: "NavigationColor") ?? .black
    ) {
        let cartImage = UIImage(systemName: "cart.fill")?.withRenderingMode(
            .alwaysTemplate
        )
        let cartButton = UIBarButtonItem(
            image: cartImage,
            style: .plain,
            target: target,
            action: action
        )
        cartButton.tintColor = tintColor
        self.navigationItem.rightBarButtonItem = cartButton
    }

}
