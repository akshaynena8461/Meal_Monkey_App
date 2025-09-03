
import OTPFieldView
extension OTPViewController: UITextFieldDelegate {
    
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        
        // 1️⃣ Allow only numeric input
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        guard allowedCharacters.isSuperset(of: characterSet) else {
            return false // Ignore non-numeric input
        }
        
        // 2️⃣ Prevent pasting or multiple characters
        if string.count > 1 {
            return false
        }
        
        // 3️⃣ Handle input of a single digit
        if string.count == 1 {
            textField.text = string // Set the current text field manually
            
            // Move focus to the next text field
            switch textField {
            case txtDigit1:
                txtDigit2.becomeFirstResponder()
            case txtDigit2:
                txtDigit3.becomeFirstResponder()
            case txtDigit3:
                txtDigit4.becomeFirstResponder()
            case txtDigit4:
                txtDigit4.resignFirstResponder() // Last field: dismiss keyboard
            default:
                break
            }
            return false // Return false because we've manually updated the text field
        }
//         4️⃣ Handle backspace / deleting a digit
        else if string.isEmpty {
            // Move focus to the previous text field
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
            textField.text = "" // Clear current text field
            return false
        }
        
        return true // Default case (shouldn't occur)
    }
}

extension OTPViewController: OTPFieldViewDelegate {
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        return true
    }

    func enteredOTP(otp: String) {
        print("Entered OTP is \(otp)")
    }

    func hasEnteredAllOTP(hasEnteredAll: Bool) -> Bool {
        return hasEnteredAll
    }
}
