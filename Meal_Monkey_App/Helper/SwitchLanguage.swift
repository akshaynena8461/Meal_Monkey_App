import Foundation

class SwitchLanguage {
    class func localizable(key: String, loc: String) -> String {
        if let path = Bundle.main.path(forResource: loc, ofType: "lproj"),
            let bundle = Bundle(path: path)
        {

            return NSLocalizedString(
                key,
                tableName: nil,
                bundle: bundle,
                value: "",
                comment: ""
            )
        }
        return key

    }
}
