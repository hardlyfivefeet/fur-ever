import Foundation
import SiestaUI
import UIKit

class AnimalSearchResultViewController: UIViewController {
    
    var animal: Animal!

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
        loadAnimalInfo()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollView.flashScrollIndicators()
    }
    
    private func loadAnimalInfo() {
        image.imageURL = animal.image.url
        name.text = animal.name
        type.text = animal.type
        breed.text = (animal.breed.primary ?? "None") + (animal.breed.secondary ?? "") + (animal.breed.mixed ?? false ? "Mix" : "")
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

        var address: String = ""
        address = address + (street.isEmpty ? "" : street + ", ")
        address = address + (city.isEmpty ? "" : city + " ")
        address = address + (state.isEmpty ? "" : state)

        var contactInfo: String = ""
        contactInfo = contactInfo + (email.isEmpty ? "" : "Email: " + email + "\n")
        contactInfo = contactInfo + (phone.isEmpty ? "" : "Phone: " + phone + "\n")
        contactInfo = contactInfo + (address.isEmpty ? "" : "Address: " + address)
        contact.text = contactInfo
    }
}
