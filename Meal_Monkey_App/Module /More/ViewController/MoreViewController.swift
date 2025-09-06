import UIKit

// MARK: - MoreViewController
// ViewController for displaying the "More" menu items
class MoreViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var lblTitle: UILabel!  // Label for page title
    @IBOutlet weak var tblMoreView: UITableView!  // TableView for More menu items

    // MARK: - Data
    var arrMore = MoreModel.addMoreData()  // Array containing menu items

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateCartBadge),
            name: .cartUpdated,
            object: nil
        )

        // Set the page title
        setLeftAlignedTitle("More")
        tblMoreView.showsVerticalScrollIndicator = false

        // Add cart button to navigation bar
        setCartButton(target: self, action: #selector(cartButtonTapped))

        // Register the custom cell for the table view
        tblMoreView.register(
            UINib(nibName: Main.CellIdentifiers.MoreTableViewCell, bundle: nil),
            forCellReuseIdentifier: Main.CellIdentifiers.MoreTableViewCell
        )
    }

    func showLanguagePicker() {
        let languages = AppLanguage.allCases

        // Container view for picker + toolbar
        let pickerVC = UIViewController()
        pickerVC.preferredContentSize = CGSize(
            width: view.frame.width,
            height: 250
        )

        let picker = UIPickerView(
            frame: CGRect(x: 0, y: 40, width: view.frame.width, height: 200)
        )
        picker.delegate = self
        picker.dataSource = self
        picker.tag = 100  // identify later
        picker.selectRow(
            languages.firstIndex(of: LanguageManager.shared.currentLanguage)
                ?? 0,
            inComponent: 0,
            animated: false
        )

        // Toolbar with Done button
        let toolbar = UIToolbar(
            frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40)
        )
        let done = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(doneTapped)
        )
        toolbar.items = [UIBarButtonItem.flexibleSpace(), done]

        pickerVC.view.addSubview(toolbar)
        pickerVC.view.addSubview(picker)

        // Present as action sheet
        let alert = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .actionSheet
        )
        alert.setValue(pickerVC, forKey: "contentViewController")
        present(alert, animated: true)
    }

    @objc func doneTapped() {
        if let alert = presentedViewController as? UIAlertController,
            let pickerVC = alert.value(forKey: "contentViewController")
                as? UIViewController,
            let picker = pickerVC.view.viewWithTag(100) as? UIPickerView
        {

            let selected = AppLanguage.allCases[
                picker.selectedRow(inComponent: 0)
            ]
            LanguageManager.shared.currentLanguage = selected
            print("Selected language: \(selected.displayName)")

            // reload the tableView cell at case 6
            tblMoreView.reloadRows(
                at: [IndexPath(row: 6, section: 0)],
                with: .none
            )
        }
        dismiss(animated: true)
    }

    @objc func updateCartBadge() {
        setCartButton(target: self, action: #selector(cartButtonTapped))
    }

    // MARK: - Actions
    /// Handles the cart button tap action
    @objc func cartButtonTapped() {
        print("Cart button tapped")
        let storyboard = UIStoryboard(
            name: Main.StoryBoard.ProductStoryBoard,
            bundle: nil
        )

        // Instantiate CartViewController and push it onto the navigation stack
        if let cartVc = storyboard.instantiateViewController(
            withIdentifier: Main.ViewControllers.Cart
        ) as? CartViewController {
            self.navigationController?.pushViewController(
                cartVc,
                animated: true
            )
        }
    }
}
