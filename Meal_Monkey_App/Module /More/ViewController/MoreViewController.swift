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
        //        setLeftAlignedTitle(Main.NavTitle.more)
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
        picker.tag = 100
        picker.selectRow(
            languages.firstIndex(of: LanguageManager.shared.currentLanguage)
                ?? 0,
            inComponent: 0,
            animated: false
        )

        // Toolbar with Cancel and Done buttons
        let toolbar = UIToolbar(
            frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40)
        )

        let cancel = UIBarButtonItem(
            title: "Cancel",
            style: .plain,
            target: self,
            action: #selector(cancelTapped)
        )
        let flexibleSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        let done = UIBarButtonItem(
            title: "Done",
            style: .done,
            target: self,
            action: #selector(doneTapped)
        )

        toolbar.items = [cancel, flexibleSpace, done]

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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setLeftAlignedTitle(Main.NavTitle.more)
        tblMoreView.reloadData()
    }

    @objc func cancelTapped() {
        dismiss(animated: true)
    }

    @objc func doneTapped() {
        // Get selected row and update language
        if let picker = (self.presentedViewController as? UIAlertController)?
            .value(forKey: "contentViewController") as? UIViewController,
            let languagePicker = picker.view.subviews.compactMap({
                $0 as? UIPickerView
            }).first
        {
            let selectedRow = languagePicker.selectedRow(inComponent: 0)
            let selectedLanguage = AppLanguage.allCases[selectedRow]

            // Set the selected language
            LanguageManager.shared.currentLanguage = selectedLanguage
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
