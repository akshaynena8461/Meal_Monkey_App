import DZNEmptyDataSet
import EmptyDataSet_Swift
import UIKit

class EmptyLabelViewController: UIViewController {

    var loader: UIActivityIndicatorView!
    var emptyLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        print("hello")
        
    }
}

extension EmptyLabelViewController: DZNEmptyDataSetSource,
    DZNEmptyDataSetDelegate
{
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString?
    {
        let text = "Nothing Here Yet"
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 22),
            .foregroundColor: UIColor.systemGray,
        ]
        return NSAttributedString(string: text, attributes: attributes)
    }

    func description(forEmptyDataSet scrollView: UIScrollView)
        -> NSAttributedString?
    {
        let text = "Start adding items or check back later."
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16),
            .foregroundColor: UIColor.systemGray2,
        ]
        return NSAttributedString(string: text, attributes: attributes)
    }

    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        return UIImage(systemName: "tray")
    }

    func backgroundColor(forEmptyDataSet scrollView: UIScrollView) -> UIColor? {
        return UIColor.systemGroupedBackground
    }

    func buttonTitle(
        forEmptyDataSet scrollView: UIScrollView,
        for state: UIControl.State
    ) -> NSAttributedString? {
        let text = "Reload"
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16, weight: .semibold),
            .foregroundColor: UIColor.systemBlue,
        ]
        return NSAttributedString(string: text, attributes: attributes)
    }

    func emptyDataSet(_ scrollView: UIScrollView, didTap button: UIButton)
    {
        print("Reload tapped")
    }
}
