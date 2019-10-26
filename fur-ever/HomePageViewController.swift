import Foundation
import UIKit

class HomePageViewController : UIViewController {

    override func viewDidLoad() {
     super.viewDidLoad()
    }
 
    @IBAction func locationButton(_ sender: Any) {
        (sender as! UIButton).tag = 0
        performSegue(withIdentifier: "tabBarSegue", sender: sender)
    }
    
    @IBAction func organizationButton(_ sender: Any) {
        (sender as! UIButton).tag = 1
        performSegue(withIdentifier: "tabBarSegue", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tabBarSegue" {
            if let vc = segue.destination as? UITabBarController {
                vc.selectedIndex = (sender as! UIButton).tag
            }
        }
    }
}
