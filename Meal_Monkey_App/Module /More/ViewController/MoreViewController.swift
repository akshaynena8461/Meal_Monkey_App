import UIKit

// MARK: - MoreViewController
// ViewController for displaying the "More" menu items
class MoreViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tblMoreView: UITableView!  // TableView for More menu items

    // MARK: - Data
    var arrMore = MoreModel.addMoreData()  // Array containing menu items
    let languages = AppLanguage.allCases
    let themes = ThemeManager.Theme.allCases

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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyLocalization()
        applyTheme()
        tblMoreView.reloadData()
    }

    func showPicker(type: PickerType) {
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
        picker.tag = (type == .language) ? 6 : 7
        pickerVC.view.addSubview(picker)

        // Select current value
        if type == .language {
            picker.selectRow(
                AppLanguage.allCases.firstIndex(
                    of: LanguageManager.shared.currentLanguage
                ) ?? 0,
                inComponent: 0,
                animated: false
            )
        } else {
            picker.selectRow(
                ThemeManager.Theme.allCases.firstIndex(
                    of: ThemeManager.shared.currentTheme
                ) ?? 0,
                inComponent: 0,
                animated: false
            )
        }

        // Toolbar with Cancel + Done
        let toolbar = UIToolbar(
            frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40)
        )
        let cancel = UIBarButtonItem(
            title: "Cancel",
            style: .plain,
            target: self,
            action: #selector(cancelPicker)
        )
        let flex = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        let done = UIBarButtonItem(
            title: "Done",
            style: .done,
            target: self,
            action: (type == .language)
                ? #selector(doneLanguagePicker) : #selector(doneThemePicker)
        )
        toolbar.setItems([cancel, flex, done], animated: false)

        pickerVC.view.addSubview(toolbar)

        let alert = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .actionSheet
        )
        alert.setValue(pickerVC, forKey: "contentViewController")
        present(alert, animated: true)
    }

    @objc func cancelPicker() {
        dismiss(animated: true)
    }

    func applyLocalization() {
        setLeftAlignedTitle(Main.NavTitle.more)
    }

    @objc func doneLanguagePicker() {
        if let alert = presentedViewController as? UIAlertController,
            let pickerVC = alert.value(forKey: "contentViewController")
                as? UIViewController,
            let picker = pickerVC.view.subviews.compactMap({
                $0 as? UIPickerView
            }).first
        {
            let selectedRow = picker.selectedRow(inComponent: 0)
            let selectedLanguage = AppLanguage.allCases[selectedRow]
            LanguageManager.shared.currentLanguage = selectedLanguage
            applyLocalization()
        }
        dismiss(animated: true)
    }

    @objc func doneThemePicker() {
        if let alert = presentedViewController as? UIAlertController,
            let pickerVC = alert.value(forKey: "contentViewController")
                as? UIViewController,
            let picker = pickerVC.view.subviews.compactMap({
                $0 as? UIPickerView
            }).first
        {
            let selectedRow = picker.selectedRow(inComponent: 0)
            let selectedTheme = ThemeManager.Theme.allCases[selectedRow]
            ThemeManager.shared.setTheme(selectedTheme)
            applyTheme()
        }
        dismiss(animated: true)
    }

    func applyTheme() {
        let theme = ThemeManager.shared
        tblMoreView.backgroundColor = theme.backgroundColor()
        view.backgroundColor = theme.backgroundColor()
        self.navigationItem.titleView?.backgroundColor = theme.backgroundColor()
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

enum PickerType {
    case language
    case theme
}
