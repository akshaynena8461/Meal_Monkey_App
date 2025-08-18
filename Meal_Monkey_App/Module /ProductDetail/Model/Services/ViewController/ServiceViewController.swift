import UIKit

class ServiceViewController: UIViewController {

    @IBOutlet weak var btnNext: UIButton!
    var arrService: [String] = [
        "Find food you love vector",
        "Delivery vector",
        "Live tracking vector",
    ]

    @IBOutlet weak var collectionIntro: UICollectionView!
    @IBOutlet weak var lblTitle2: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var lblTItle1: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        lblTItle1.text = "Find Food You Love"
        lblTitle2.text =
            "Discover the best foods from over 1,000 restaurants and fast delivery to your doorstep"

        EditStyle.setborder(textfields: [btnNext], cornerRadious: 28)

        collectionIntro.register(
            UINib(nibName: "ServiceCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "ServiceCollectionViewCell"
        )
    }
    @IBAction func btnNextClick(_ sender: Any) {

        let currentPage = pageControl.currentPage

        if currentPage < arrService.count - 1 {
            let nextPage = currentPage + 1
            let xOffset = CGFloat(nextPage) * collectionIntro.frame.width
            collectionIntro.setContentOffset(
                CGPoint(x: xOffset, y: 0),
                animated: true
            )
            pageControl.currentPage = nextPage
            updateLabels(for: nextPage)
        } else {
            let storyboard = UIStoryboard(name: "HomeStoryBoard", bundle: nil)
            if let signUpVC = storyboard.instantiateViewController(
                withIdentifier: "TabBarViewController"
            ) as? TabBarViewController {
                self.navigationController?.pushViewController(
                    signUpVC,
                    animated: true
                )
            }
        }
    }

    func updateLabels(for page: Int) {
        switch page {
        case 0:
            lblTItle1.text = "Find Food You Love"
            lblTitle2.text =
                "Discover the best foods from over 1,000 restaurants and fast delivery to your doorstep"
            btnNext.setTitle("Next", for: .normal)
        case 1:
            lblTItle1.text = "Fast Delivery"
            lblTitle2.text =
                "Fast food delivery to your home, office wherever you are"
            btnNext.setTitle("Next", for: .normal)
        case 2:
            lblTItle1.text = "Live Tracking"
            lblTitle2.text =
                "Real time tracking of your food on the app once you placed the order"
            btnNext.setTitle("Done", for: .normal)
        default:
            break
        }
    }
}
