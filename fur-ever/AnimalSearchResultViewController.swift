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
    @IBOutlet weak var contact: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAnimalInfo()
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
//        contact.text = (animal.contact.email ? (animal.contact.email ?? "") + "\n" : "") +
//            (animal.contact.phone ? animal.contact.phone + "\n" : "") +
//            (animal.contact.location.street ?? "" + animal.contact.location.city ?? "" + animal.contact.location.state ?? "")
    }
}
