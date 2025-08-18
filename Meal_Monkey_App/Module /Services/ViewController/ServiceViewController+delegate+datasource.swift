import UIKit

extension ServiceViewController: UICollectionViewDataSource,
    UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    internal func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell: ServiceCollectionViewCell =
            collectionView.dequeueReusableCell(
                withReuseIdentifier: "ServiceCollectionViewCell",
                for: indexPath
            ) as! ServiceCollectionViewCell

        cell.imgView.image = UIImage(named: arrService[indexPath.item])

        return cell
    }

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return arrService.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSizeMake(collectionIntro.frame.size.width, 300)
    }

}

extension ServiceViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = Int(
            scrollView.contentOffset.x / scrollView.frame.size.width
        )
        pageControl.currentPage = pageNumber

        switch pageNumber + 1 {
        case 1:
            lblTItle1.text = "Find Food You Love"
            lblTitle2.text =
                "Discover the best foods from over 1,000 restaurants and fast delivery to your doorstep"
            btnNext.setTitle("Next", for: .normal)

        case 2:
            lblTItle1.text = "Fast Delivery"
            lblTitle2.text =
                "Fast food delivery to your home, office wherever you are"
            btnNext.setTitle("Next", for: .normal)

        case 3:
            lblTItle1.text = "Live Tracking"
            lblTitle2.text =
                "Real time tracking of your food on the app once you placed the order"
            btnNext.setTitle("Done", for: .normal)

        default:
            break

        }
    }
}
