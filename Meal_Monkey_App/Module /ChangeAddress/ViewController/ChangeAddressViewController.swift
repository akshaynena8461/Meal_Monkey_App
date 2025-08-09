

import UIKit

class ChangeAddressViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLeftAlignedTitleWithBack("Change Address", target: self, action: #selector(BackBtnTapped))

    }
    
    @objc func BackBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }

}
