import Foundation
import UIKit
import SiestaUI

class OrganizationSearchResultViewController: UIViewController {
    
    var organization: Organization!

    @IBOutlet weak var image: RemoteImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var missionStatement: UILabel!
    @IBOutlet weak var contact: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadOrganizationInfo()
    }
    
    private func loadOrganizationInfo() {
        image.imageURL = organization.image.url
        name.text = organization.name
        missionStatement.text = organization.missionStatement
        
        let email = organization.contact.email ?? ""
        let phone = organization.contact.phone ?? ""
        let website = organization.contact.website ?? ""
        let street = organization.contact.location.street ?? ""
        let city = organization.contact.location.city ?? ""
        let state = organization.contact.location.state ?? ""

        var address: String = ""
        address = address + (street.isEmpty ? "" : street + ", ")
        address = address + (city.isEmpty ? "" : city + " ")
        address = address + (state.isEmpty ? "" : state)

        var contactInfo: String = ""
        contactInfo = contactInfo + (email.isEmpty ? "" : "Email: " + email + "\n")
        contactInfo = contactInfo + (phone.isEmpty ? "" : "Phone: " + phone + "\n")
        contactInfo = contactInfo + (website.isEmpty ? "" : "Website: " + website + "\n")
        contactInfo = contactInfo + (address.isEmpty ? "" : "Address: " + address)
        contact.text = contactInfo
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
    // TODO: implement this
    }
}
