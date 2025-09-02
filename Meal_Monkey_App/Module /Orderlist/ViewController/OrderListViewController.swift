import Lottie
import UIKit

/// ViewController to display list of orders for the current user
class OrderListViewController: UIViewController {

    @IBOutlet weak var lblEmpty: UILabel!  // Label shown when there are no orders
    @IBOutlet weak var tblOrderList: UITableView!  // TableView to show orders

    override func viewDidLoad() {
        super.viewDidLoad()

        lblEmpty.isHidden = true

        if app.arrOrder.isEmpty {
            setEmptyBackgroundViewWithLottie()
        }

        setLeftAlignedTitleWithBack(
            "Order List",
            target: self,
            action: #selector(backBtnTapped)
        )

        // ⚠️ Use register only if using XIB, not storyboard prototype cell
        tblOrderList.register(
            UINib(
                nibName: Main.CellIdentifiers.OrderListTableViewCell,
                bundle: nil
            ),
            forCellReuseIdentifier: Main.CellIdentifiers.OrderListTableViewCell
        )
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Fetch orders for the logged-in user from Core Data
        if let currentUserEmail = UserDefaults.standard.string(
            forKey: "loggedInUserEmail"
        ),
            let user = CoreDataManager.shared.fetchUserbyEmail(
                byEmail: currentUserEmail
            )
        {

            app.arrOrder = CoreDataManager.shared.fetchOrders(for: user)
        }
        print("app.arrOrder \(app.arrOrder)")

        // Show/hide empty label depending on whether there are orders
        if app.arrOrder.isEmpty {
            setEmptyBackgroundViewWithLottie()
        } else {
            tblOrderList.backgroundView = nil  // 👈 remove empty view
        }
        tblOrderList.reloadData()
    }

    func setEmptyBackgroundViewWithLottie() {
        let backgroundView = UIView(frame: self.view.bounds)

        // Lottie Animation View
        let animationView = LottieAnimationView(name: "Empty Order")
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        animationView.translatesAutoresizingMaskIntoConstraints = false

        // Label
        let messageLabel = UILabel()
        messageLabel.textColor = .gray
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false

        backgroundView.addSubview(animationView)
        backgroundView.addSubview(messageLabel)

        NSLayoutConstraint.activate([
            animationView.centerXAnchor.constraint(
                equalTo: backgroundView.centerXAnchor
            ),
            animationView.centerYAnchor.constraint(
                equalTo: backgroundView.centerYAnchor,
                constant: -40
            ),
            animationView.widthAnchor.constraint(equalToConstant: 200),
            animationView.heightAnchor.constraint(equalToConstant: 200),

            messageLabel.topAnchor.constraint(
                equalTo: animationView.bottomAnchor,
                constant: 16
            ),
            messageLabel.centerXAnchor.constraint(
                equalTo: backgroundView.centerXAnchor
            ),
        ])

        tblOrderList.backgroundView = backgroundView
    }

    /// Back button action
    @objc func backBtnTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
