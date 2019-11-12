import Foundation
import SiestaUI
import UIKit

class AnimalSearchResultViewController: UIViewController {

    var api: Api!
    var failureCallback: ((Error) -> Void)?

    var animalResult: AnimalResultInfo!
    var animalId: Int!
    var searchDistance: Double!
    var urlToWebsite: String?

    @IBOutlet weak var image: RemoteImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var breed: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var coat: UILabel!
    @IBOutlet weak var size: UILabel!
    @IBOutlet weak var attributes: UILabel!
    @IBOutlet weak var environment: UILabel!
    @IBOutlet weak var contact: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        api = appDelegate.api
        if api.tokenHasExpired() {
            api.getToken(with: TokenRequestParams(), fail: failureCallback ?? report)
        }
        api.getAnimal(with: animalId, then: display, fail: failureCallback ?? report)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollView.flashScrollIndicators()
    }

    private func display(animalResult: AnimalResultInfo) {
        let animal: Animal = animalResult.animal
        if animal.photos.count != 0 {
            image.imageURL = animal.photos[0].full
        } else {
            image.image = UIImage(named: "NoImageAvailable")
        }
        name.text = animal.name
        let notAvailable = "Not Available"
        distance.text = "Distance: " + (searchDistance == nil ? notAvailable : "\(searchDistance!) miles")
        let secondaryBreed = animal.breeds.secondary ?? ""
        breed.text = "Breed: " + (animal.breeds.primary ?? "Unknown") + (secondaryBreed.isEmpty ? "" : ", " + secondaryBreed) + (animal.breeds.mixed ?? false ? " Mix" : "")
        age.text = "Age: " + (animal.age ?? notAvailable)
        gender.text = "Gender: " + (animal.gender ?? notAvailable)
        coat.text = "Coat: " + (animal.coat ?? notAvailable)
        size.text = "Size: " + (animal.size ?? notAvailable)
        attributes.text = (animal.attributes.house_trained ?? false ? "House-trained\n" : "Not house-trained\n") + (animal.attributes.spayed_neutered ?? false ? "Spayed/Neutered" : "Not spayed/neutered")
        environment.text = (animal.environment.children ?? false ? "Good with children\n" : "Not good with children\n") + (animal.environment.dogs ?? false ? "Good with other dogs\n" : "Not good with other dogs\n") + (animal.environment.cats ?? false ? "Good with other cats" : "Not good with other cats")

        let email = animal.contact.email ?? ""
        let phone = animal.contact.phone ?? ""
        let street = animal.contact.address.address1 ?? ""
        let city = animal.contact.address.city ?? ""
        let state = animal.contact.address.state ?? ""

        var address = (street.isEmpty ? "" : street + ", ")
        address = address + (city.isEmpty ? "" : city + " ")
        address = address + (state.isEmpty ? "" : state)

        var contactInfo = (email.isEmpty ? "" : "Email: " + email + "\n")
        contactInfo = contactInfo + (phone.isEmpty ? "" : "Phone: " + phone + "\n")
        contactInfo = contactInfo + (address.isEmpty ? "" : "Address: " + address)
        contact.text = contactInfo.isEmpty ? "No contact information available" : contactInfo

        urlToWebsite = animal.url!
    }

    private func report(error: Error) {
        let alert = UIAlertController(title: "Network Issue",
           message: "Sorry, we seem to have encountered a network problem: \(error.localizedDescription)",
           preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Acknowledge", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let webViewController = segue.destination as? WebViewController {
            webViewController.url = urlToWebsite
        }
    }
}

// Removes left padding so text views are aligned with labels
class CustomTextView: UITextView {
    override func draw(_ rect: CGRect) {
        textContainer.lineFragmentPadding = 0
        textContainerInset = .zero
}}
