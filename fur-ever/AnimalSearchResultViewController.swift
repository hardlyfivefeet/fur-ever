import Foundation
import SiestaUI
import UIKit

class AnimalSearchResultViewController: UIViewController {

    var api: Api = ProcessInfo.processInfo.arguments.contains(TESTING_UI) ?
           MockApiService() : ApiService()
    var failureCallback: ((Error) -> Void)?

    var animal: Animal!
    var animalId: Int!

    @IBOutlet weak var image: RemoteImageView!
    @IBOutlet weak var name: UILabel!
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
        image.imageURL = animal.basicInfo.image.url
        name.text = animal.basicInfo.name
        type.text = animal.type
        let secondaryBreed = animal.breed.secondary ?? ""
        breed.text = (animal.breed.primary ?? "Unknown") + (secondaryBreed.isEmpty ? "" : ", " + secondaryBreed) + (animal.breed.mixed ?? false ? " Mix" : "")
        age.text = animal.age
        gender.text = animal.gender
        size.text = animal.size
        info.text = animal.description
        attributes.text = (animal.attributes.house_trained ? "House-trained\n" : "") + (animal.attributes.spayed_neutered ? "Spayed/Neutered" : "")

        let email = animal.contact.email ?? ""
        let phone = animal.contact.phone ?? ""
        let street = animal.contact.location.street ?? ""
        let city = animal.contact.location.city ?? ""
        let state = animal.contact.location.state ?? ""

        var address = (street.isEmpty ? "" : street + ", ")
        address = address + (city.isEmpty ? "" : city + " ")
        address = address + (state.isEmpty ? "" : state)

        var contactInfo = (email.isEmpty ? "" : "Email: " + email + "\n")
        contactInfo = contactInfo + (phone.isEmpty ? "" : "Phone: " + phone + "\n")
        contactInfo = contactInfo + (address.isEmpty ? "" : "Address: " + address)
        contact.text = contactInfo
    }

    private func report(error: Error) {
        let alert = UIAlertController(title: "Network Issue",
           message: "Sorry, we seem to have encountered a network problem: \(error.localizedDescription)",
           preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Acknowledge", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
