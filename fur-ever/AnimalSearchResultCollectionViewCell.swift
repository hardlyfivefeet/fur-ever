import Foundation
import UIKit
import SiestaUI

class AnimalSearchResultCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var thumbnailPhoto: RemoteImageView!
    @IBOutlet weak var thumbnailName: UILabel!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!

    override func prepareForReuse() {
        super.prepareForReuse()
        loadingView.startAnimating()
    }
}
