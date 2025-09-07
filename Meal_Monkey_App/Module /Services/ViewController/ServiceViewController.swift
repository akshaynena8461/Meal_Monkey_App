import UIKit

class ServiceViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var internalView: UIView!
    @IBOutlet weak var btnNext: UIButton!  // Button to navigate to next page
    @IBOutlet weak var collectionIntro: UICollectionView!  // Collection view for intro images
    @IBOutlet weak var lblTitle2: UILabel!  // Subtitle label
    @IBOutlet weak var pageControl: UIPageControl!  // Page control indicator
    @IBOutlet weak var lblTItle1: UILabel!  // Main title label

    // MARK: - Properties
    var arrService: [String] = [
        "Find food you love vector",
        "Delivery vector",
        "Live tracking vector",
    ]  // Array of service images (or descriptions) to display in collection view

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Initial setup of labels
        lblTItle1.text = Main.Services.serviceTitle1
        lblTitle2.text = Main.Services.serviceMsg1
        btnNext.setTitle(
            LanguageManager.shared.localizedString(for: "8461_next_button"),
            for: .normal
        )

        // Styling the Next button
        EditStyle.setborder(textfields: [btnNext], cornerRadious: 28)

        // Register collection view cell
        collectionIntro.register(
            UINib(
                nibName: Main.CellIdentifiers.ServiceCollectionViewCell,
                bundle: nil
            ),
            forCellWithReuseIdentifier: Main.CellIdentifiers
                .ServiceCollectionViewCell
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
            } else {
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyAccentTheme()
    }

    func applyAccentTheme() {
        let theme = ThemeManager.shared

        view.backgroundColor = theme.backgroundColor()
        mainView.backgroundColor = theme.backgroundColor()
        internalView.backgroundColor = theme.backgroundColor()
        collectionIntro.backgroundColor = theme.backgroundColor()
        pageControl.currentPageIndicatorTintColor = theme.primaryButtonBackground()

        lblTItle1.textColor = theme.textColor()
        lblTitle2.textColor = theme.subTextColor()

        btnNext.setTitleColor(.white, for: .normal)
        btnNext.backgroundColor = theme.primaryButtonBackground()
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
            btnNext.setTitle(
                LanguageManager.shared.localizedString(for: "8461_next_button"),
                for: .normal
            )
        case 1:
            lblTItle1.text = Main.Services.serviceTitle2
            lblTitle2.text =
                Main.Services.serviceMsg2
            btnNext.setTitle(
                LanguageManager.shared.localizedString(for: "8461_next_button"),
                for: .normal
            )
        case 2:
            lblTItle1.text = Main.Services.serviceTitle3
            lblTitle2.text =
                Main.Services.serviceMsg3
            btnNext.setTitle(
                LanguageManager.shared.localizedString(for: "8461_done_button"),
                for: .normal
            )
        default:
            break
        }
    }
}
