import Foundation
import UIKit

class InfoPageViewController: UIViewController {

    @IBAction func openURL(_ sender: Any) {
        if let url = URL(string: "https://www.petfinder.com") {
            UIApplication.shared.open(url)
        }
    }
}
