
import UIKit

class MoreTableViewCell: UITableViewCell {

    @IBOutlet weak var btnArrow: UIButton!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()

        imgView.layer.borderWidth = 1

        mainView.layer.cornerRadius = 7
        btnArrow.layer.cornerRadius = 50
        imgView.layer.borderColor =
            UIColor(named: "More_icons_border_color")?.cgColor

        imgView.layer.cornerRadius = imgView.frame.size.width / 2
        imgView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configMoreCell(more: MoreModel) {
        lblTitle.text = more.strTitle
        imgView.image = UIImage(named: more.strImage ?? "")
    }
}
