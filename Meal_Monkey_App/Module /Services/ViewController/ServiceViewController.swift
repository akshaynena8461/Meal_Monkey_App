import UIKit

class ServiceViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var btnNext: UIButton!                 // Button to navigate to next page
    @IBOutlet weak var collectionIntro: UICollectionView! // Collection view for intro images
    @IBOutlet weak var lblTitle2: UILabel!               // Subtitle label
    @IBOutlet weak var pageControl: UIPageControl!       // Page control indicator
    @IBOutlet weak var lblTItle1: UILabel!               // Main title label

    // MARK: - Properties
    var arrService: [String] = [
        "Find food you love vector",
        "Delivery vector",
        "Live tracking vector",
    ] // Array of service images (or descriptions) to display in collection view

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Initial setup of labels
        lblTItle1.text = "Find Food You Love"
        lblTitle2.text = "Discover the best foods from over 1,000 restaurants and fast delivery to your doorstep"

        // Styling the Next button
        EditStyle.setborder(textfields: [btnNext], cornerRadious: 28)

        // Register collection view cell
        collectionIntro.register(
            UINib(nibName: "ServiceCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "ServiceCollectionViewCell"
        )
    }

    // MARK: - Actions
    @IBAction func btnNextClick(_ sender: Any) {

        let currentPage = pageControl.currentPage // Get current page from page control

        if currentPage < arrService.count - 1 {
            // If not on the last page, scroll to the next page
            let nextPage = currentPage + 1
            let xOffset = CGFloat(nextPage) * collectionIntro.frame.width
            collectionIntro.setContentOffset(
                CGPoint(x: xOffset, y: 0),
                animated: true
            )
            pageControl.currentPage = nextPage
            updateLabels(for: nextPage) // Update labels for new page
        } else {
            // If on last page, navigate to main app (TabBar)
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

    // MARK: - Helper Methods
    /// Updates the main and subtitle labels based on current page
    /// Also changes the Next button text if needed
    /// - Parameter page: The current page index
    func updateLabels(for page: Int) {
        switch page {
        case 0:
            lblTItle1.text = "Find Food You Love"
            lblTitle2.text = "Discover the best foods from over 1,000 restaurants and fast delivery to your doorstep"
            btnNext.setTitle("Next", for: .normal)
        case 1:
            lblTItle1.text = "Fast Delivery"
            lblTitle2.text = "Fast food delivery to your home, office wherever you are"
            btnNext.setTitle("Next", for: .normal)
        case 2:
            lblTItle1.text = "Live Tracking"
            lblTitle2.text = "Real time tracking of your food on the app once you placed the order"
            btnNext.setTitle("Done", for: .normal)
        default:
            break
        }
    }
}
