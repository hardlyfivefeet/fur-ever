import Foundation
import UIKit

class SearchByLocationFormViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var petType: UISegmentedControl!
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var searchButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        self.locationField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
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
        searchButton.isEnabled = (locationField.text ?? "").count > 0
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let animalSearchResultCollectionViewController = segue.destination as? AnimalSearchResultCollectionViewController,
           let location = locationField.text {
            let animalType = petType.titleForSegment(at: petType.selectedSegmentIndex)
            animalSearchResultCollectionViewController.searchParams = AnimalSearchParams(animalType!, location)
        }
    }
}
