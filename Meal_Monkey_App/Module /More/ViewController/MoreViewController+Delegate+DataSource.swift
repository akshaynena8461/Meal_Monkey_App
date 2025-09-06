import UIKit

// MARK: - UITableView Delegate & DataSource for MoreViewController
extension MoreViewController: UITableViewDelegate, UITableViewDataSource,
    UIPickerViewDelegate, UIPickerViewDataSource
{

    // MARK: - Number of Rows
    /// Returns the number of rows in the table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        return arrMore.count  // Number of menu items
    }

    // MARK: - Cell Configuration
    /// Configures each cell for the More menu
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        // Dequeue reusable cell
        let cell =
            tableView.dequeueReusableCell(
                withIdentifier: Main.CellIdentifiers.MoreTableViewCell,
                for: indexPath
            ) as! MoreTableViewCell

        if arrMore[indexPath.row].intTag == 6 {
            cell.lblTitle?.text = LanguageManager.shared.currentLanguage.displayName
        }

        // Configure cell with MoreModel data
        cell.configMoreCell(more: arrMore[indexPath.row])

        // Remove selection style highlight
        cell.selectionStyle = .none

        return cell
    }

    // MARK: - Row Selection
    /// Handles what happens when a user taps a row
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        // Deselect the row after tapping
        tableView.deselectRow(at: indexPath, animated: true)

        // Get selected row
        let row = indexPath.row
        let storyboard = UIStoryboard(
            name: Main.StoryBoard.MoreStoryBoard,
            bundle: nil
        )

        // Get the menu item's tag to determine action
        let selectedItem = arrMore[row].intTag

        switch selectedItem {

        case 0:
            // Payment Details
            print("Payment Details selected")
            if let paymentvc = storyboard.instantiateViewController(
                withIdentifier: Main.ViewControllers.payment
            ) as? PaymentViewController {
                self.navigationController?.pushViewController(
                    paymentvc,
                    animated: true
                )
            }

        case 1:
            // My Orders
            print("My Orders selected")
            let storyboard = UIStoryboard(
                name: Main.StoryBoard.ProductStoryBoard,
                bundle: nil
            )
            if let orderlistVc = storyboard.instantiateViewController(
                withIdentifier: Main.ViewControllers.Orderlist
            ) as? OrderListViewController {
                self.navigationController?.pushViewController(
                    orderlistVc,
                    animated: true
                )
            }

        case 2:
            // Notifications
            print("Notification selected")
            if let aboutvc = storyboard.instantiateViewController(
                withIdentifier: Main.ViewControllers.About
            ) as? AboutUsViewController {
                aboutvc.objPagetype = .Notification
                self.navigationController?.pushViewController(
                    aboutvc,
                    animated: true
                )
            }

        case 3:
            // Inbox
            print("Inbox selected")
            if let aboutvc = storyboard.instantiateViewController(
                withIdentifier: Main.ViewControllers.About
            ) as? AboutUsViewController {
                aboutvc.objPagetype = .Inbox
                self.navigationController?.pushViewController(
                    aboutvc,
                    animated: true
                )
            }

        case 4:
            // About Us
            print("About Us selected")
            if let aboutvc = storyboard.instantiateViewController(
                withIdentifier: Main.ViewControllers.About
            ) as? AboutUsViewController {
                self.navigationController?.pushViewController(
                    aboutvc,
                    animated: true
                )
            }

        case 5:
            // WishList
            print("WishList Page")
            if let wishlistVc = storyboard.instantiateViewController(
                withIdentifier: Main.ViewControllers.Wishlist
            ) as? WishListViewController {
                // Uncomment and set wishlist items if needed
                // wishlistVc.arrWishlistItems = app.arrWishList
                self.navigationController?.pushViewController(
                    wishlistVc,
                    animated: true
                )
            }

        case 6:
            print("select Language")
            showLanguagePicker()
    
        default:
            break
        }
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }
    func pickerView(
        _ pickerView: UIPickerView,
        numberOfRowsInComponent component: Int
    ) -> Int {
        AppLanguage.allCases.count
    }
    func pickerView(
        _ pickerView: UIPickerView,
        titleForRow row: Int,
        forComponent component: Int
    ) -> String? {
        AppLanguage.allCases[row].displayName
    }
}

// MARK: - Enum for More Menu Pages
/// Defines the different page types that can be navigated to from the More menu
enum PageType {
    case PayMent
    case MyOrders
    case Notification
    case Inbox
    case AboutUs
    case WishList
}
