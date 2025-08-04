//
//  NewPasswordViewController.swift
//  Meal_Monkey_App
//
//  Created by Akshay Nena on 04/08/25.
//

import UIKit

class NewPasswordViewController: UIViewController {

    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        EditStyle.setborder(textfields: [btnNext,txtPassword,txtConfirmPassword])
        
        EditStyle.setPadding(textFields: [txtPassword,txtConfirmPassword], paddingWidth: 34)

    }

    @IBAction func btnNextClick(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Services", bundle: nil)
            if let signUpVC = storyboard.instantiateViewController(withIdentifier: "ServiceViewController") as? ServiceViewController {
                self.navigationController?.pushViewController(signUpVC, animated: true)
            }
        
    }
    
}
