import UIKit

// MARK: - Collection View DataSource & Delegate
extension ServiceViewController: UICollectionViewDataSource,
    UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    // Returns the number of items in the collection view
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return arrService.count
    }

    // Configures and returns each cell
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell: ServiceCollectionViewCell =
            collectionView.dequeueReusableCell(
                withReuseIdentifier: Main.CellIdentifiers.ServiceCollectionViewCell,
                for: indexPath
            ) as! ServiceCollectionViewCell

        // Set the image for the cell based on the service array
        cell.imgView.image = UIImage(named: arrService[indexPath.item])

        return cell
    }

    // Sets the size for each collection view item
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        // Full width of collection view, height fixed at 300
        return CGSize(width: collectionIntro.frame.size.width, height: 300)
    }
}

// MARK: - Scroll View Delegate
extension ServiceViewController: UIScrollViewDelegate {

    // Called when user stops scrolling the collection view
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        // Calculate current page based on content offset
        let pageNumber = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = pageNumber

        // Update labels and Next button based on current page
        switch pageNumber + 1 {
        case 1:
            lblTItle1.text = Main.Services.serviceTitle1
            lblTitle2.text =
            Main.Services.serviceMsg1
            btnNext.setTitle(LanguageManager.shared.localizedString(for: "8461_next_button"), for: .normal)
        case 2:
            lblTItle1.text = Main.Services.serviceTitle2
            lblTitle2.text =
            Main.Services.serviceMsg2
            btnNext.setTitle(LanguageManager.shared.localizedString(for: "8461_next_button"), for: .normal)
        case 3:
            lblTItle1.text = Main.Services.serviceTitle3
            lblTitle2.text =
            Main.Services.serviceMsg3
            btnNext.setTitle(LanguageManager.shared.localizedString(for: "8461_done_button"), for: .normal)
        default:
            break
        }
    }
}
