

import NVActivityIndicatorView
import UIKit

class LoderViewController: UIViewController {

    var activityIndicator: NVActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let frame = CGRect(
            x: (view.frame.width - 50) / 2,
            y: (view.frame.height - 50) / 2,
            width: 50,
            height: 50
        )

        activityIndicator = NVActivityIndicatorView(
            frame: frame,
            type: .ballGridPulse,
            color: .systemBlue,
            padding: 0
        )
        view.addSubview(activityIndicator)
        showLoader()
    }

    func showLoader() {
        activityIndicator.startAnimating()
    }

    func hideLoader() {
        activityIndicator.stopAnimating()
    }
   

}
