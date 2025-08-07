//
//  OTPViewController.swift
//  Meal_Monkey_App
//
//  Created by Akshay Nena on 07/08/25.
//

import UIKit

class OTPViewController: UIViewController {

    @IBOutlet weak var btnDoNotReceive: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var txtDigit4: UITextField!
    @IBOutlet weak var txtDigit3: UITextField!
    @IBOutlet weak var txtDigit2: UITextField!
    @IBOutlet weak var txtDigit1: UITextField!


    override func viewDidLoad() {
        super.viewDidLoad()

        let allviews = [txtDigit1!, txtDigit2!, txtDigit3!, txtDigit4!]

        
        EditStyle.setOTPtextFieldborder(textfields: [
            txtDigit1,
            txtDigit2,
            txtDigit3,
            txtDigit4,
        ])
        EditStyle.setborder(textfields: [btnNext])

        for tf in allviews {
            tf.delegate = self
            tf.keyboardType = .numberPad
            tf.textAlignment = .center
        }

    }

    @IBAction func btnNextClick(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Services", bundle: nil)
        if let signUpVC = storyboard.instantiateViewController(
            withIdentifier: "ServiceViewController"
        ) as? ServiceViewController {
            self.navigationController?.pushViewController(
                signUpVC,
                animated: true
            )
        }
    }

    @IBAction func btnDoNotReceiveClick(_ sender: Any) {
        UIAlertController.showAlert(
            title: "Success",
            message: "OTP Sent Successfully",
            viewController: self
        )
    }

}
