import Foundation
import UIKit

class SearchByOrganizationFormViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var searchButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        self.locationField.delegate = self
        self.nameField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let organizationSearchResultTableViewController = segue.destination as? OrganizationSearchResultTableViewController,
            let name = nameField.text,
            let location = locationField.text {
            organizationSearchResultTableViewController.searchParams = OrganizationSearchParams(name: name, location: location)
        }
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let locationFieldYLocation = locationField.frame.origin.y
            let screenBottomYLocation = self.view.frame.height
            var viewOrigin = self.view.frame.origin.y
            if viewOrigin == 0 && locationFieldYLocation > (screenBottomYLocation - keyboardSize.height - 80) {
                viewOrigin = screenBottomYLocation - locationFieldYLocation - keyboardSize.height - 80
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    @IBAction func textFieldChanged(_ sender: Any) {
        updateViews()
    }

    private func updateViews() {
        searchButton.isEnabled = (nameField.text ?? "").count > 0 || (locationField.text ?? "").count > 0
    }
}
