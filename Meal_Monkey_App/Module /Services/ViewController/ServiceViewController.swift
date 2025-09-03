import UIKit

class ServiceViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var btnNext: UIButton!  // Button to navigate to next page
    @IBOutlet weak var collectionIntro: UICollectionView!  // Collection view for intro images
    @IBOutlet weak var lblTitle2: UILabel!  // Subtitle label
    @IBOutlet weak var pageControl: UIPageControl!  // Page control indicator
    @IBOutlet weak var lblTItle1: UILabel!  // Main title label

    // MARK: - Properties
    var arrService: [String] = [
        Main.Services.serviceTitle1,
        Main.Services.serviceTitle2,
        Main.Services.serviceTitle3
    ]  // Array of service images (or descriptions) to display in collection view

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Initial setup of labels
        lblTItle1.text = "Find Food You Love"
        lblTitle2.text =
            "Discover the best foods from over 1,000 restaurants and fast delivery to your doorstep"

        // Styling the Next button
        EditStyle.setborder(textfields: [btnNext], cornerRadious: 28)

        // Register collection view cell
        collectionIntro.register(
            UINib(nibName: Main.CellIdentifiers.ServiceCollectionViewCell, bundle: nil),
            forCellWithReuseIdentifier: Main.CellIdentifiers.ServiceCollectionViewCell
        )
    }

    // MARK: - Actions
    @IBAction func btnNextClick(_ sender: Any) {

        let currentPage = pageControl.currentPage  // Get current page from page control

        if currentPage < arrService.count - 1 {
            // If not on the last page, scroll to the next page
            let nextPage = currentPage + 1
            let xOffset = CGFloat(nextPage) * collectionIntro.frame.width
            collectionIntro.setContentOffset(
                CGPoint(x: xOffset, y: 0),
                animated: true
            )
            pageControl.currentPage = nextPage
            updateLabels(for: nextPage)  // Update labels for new page
        } else {
            // If on last page and if User LoggedIn, navigate to Home page (TabBar) other wise navigate to login page

            if UserDefaults.standard.bool(forKey: "isLoggedIn") {
                // User is logged in, navigate to the main tab bar
                showMainTabBar()
            }
            else {
                // User is not logged in, navigate to the Login screen
                let storyboard = UIStoryboard(name: "User", bundle: nil)
                if let vc = storyboard.instantiateViewController(
                    withIdentifier: Main.ViewControllers.Login
                ) as? LoginViewController {
                    // Push LoginViewController onto the navigation stack
                    self.navigationController?.pushViewController(
                        vc,
                        animated: true
                    )
                }
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
            lblTItle1.text = Main.Services.serviceTitle1
            lblTitle2.text =
            Main.Services.serviceMsg1
            btnNext.setTitle("Next", for: .normal)
        case 1:
            lblTItle1.text = Main.Services.serviceTitle2
            lblTitle2.text =
            Main.Services.serviceMsg2
            btnNext.setTitle("Next", for: .normal)
        case 2:
            lblTItle1.text = Main.Services.serviceTitle3
            lblTitle2.text =
            Main.Services.serviceMsg3
            btnNext.setTitle("Done", for: .normal)
        default:
            break
        }
    }
}
