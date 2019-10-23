import Foundation
import UIKit

class HomePageViewController : UIViewController {

    override func viewDidLoad() {
         super.viewDidLoad()
     }

    override public func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         navigationController?.isNavigationBarHidden = true
     }

     override public func viewDidDisappear(_ animated: Bool) {
         super.viewDidDisappear(animated)
         navigationController?.isNavigationBarHidden = false
     }
}
