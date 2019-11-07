import Foundation
import SiestaUI
import UIKit

class AnimalSearchResultViewController: UIViewController {

    var api: Api = ProcessInfo.processInfo.arguments.contains(TESTING_UI) ?
           MockApiService() : PlaceholderApiService()
    var failureCallback: ((Error) -> Void)?

    var animal: Animal!
    var animalId: Int!

    @IBOutlet weak var image: RemoteImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var breed: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var size: UILabel!
    @IBOutlet weak var info: UILabel!
    @IBOutlet weak var attributes: UILabel!
    @IBOutlet weak var contact: UITextView!

    @IBOutlet weak var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        api.api(host: "https://api.petfinder.com/v2/")
        api.getAnimal(with: animalId, then: display, fail: failureCallback ?? report)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollView.flashScrollIndicators()
    }

    private func display(selectedAnimal: Animal) {
        animal = selectedAnimal
        if animal.photos[0].full != nil {
            image.imageURL = animal.photos[0].full
        }
        name.text = animal.name
        distance.text = "Distance: " + (animal.distance == nil ? "Not available" : "\(animal.distance!)")
        type.text = animal.type
        let secondaryBreed = animal.breeds.secondary ?? ""
        breed.text = (animal.breeds.primary ?? "Unknown") + (secondaryBreed.isEmpty ? "" : ", " + secondaryBreed) + (animal.breeds.mixed ?? false ? " Mix" : "")
        age.text = animal.age ?? "Age not available"
        gender.text = animal.gender ?? "Gender not available"
        size.text = animal.size ?? "Size not available"
        info.text = animal.description ?? "No description available"
        attributes.text = (animal.attributes.house_trained ?? false ? "House-trained\n" : "") + (animal.attributes.spayed_neutered ?? false ? "Spayed/Neutered" : "")

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
    }

    private func report(error: Error) {
        let alert = UIAlertController(title: "Network Issue",
           message: "Sorry, we seem to have encountered a network problem: \(error.localizedDescription)",
           preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Acknowledge", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
