import UIKit

extension OTPViewController: UITextFieldDelegate {
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {

        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        guard allowedCharacters.isSuperset(of: characterSet) else {
            return false
        }

        if string.count > 1 {
            return false
        }

        if string.count == 1 {
            textField.text = string

            switch textField {
            case txtDigit1:
                txtDigit2.becomeFirstResponder()
            case txtDigit2:
                txtDigit3.becomeFirstResponder()
            case txtDigit3:
                txtDigit4.becomeFirstResponder()
            case txtDigit4:
                txtDigit4.resignFirstResponder()
            default:
                break
            }
            return false
        } else if string.isEmpty {
            switch textField {
            case txtDigit4:
                txtDigit3.becomeFirstResponder()
            case txtDigit3:
                txtDigit2.becomeFirstResponder()
            case txtDigit2:
                txtDigit1.becomeFirstResponder()
            default:
                break
            }
            textField.text = ""
            return false
        }
        return true
    }
}
