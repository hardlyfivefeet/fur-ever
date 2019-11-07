import Foundation
import UIKit
import SiestaUI

class OrganizationSearchResultViewController: UIViewController {

    var organization: Organization!

    @IBOutlet weak var image: RemoteImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var distance: UITextView!
    @IBOutlet weak var missionStatement: UITextView!
    @IBOutlet weak var contact: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        displayInfo()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollView.flashScrollIndicators()
    }

    private func displayInfo() {
        if organization.photos[0].full != nil {
            image.imageURL = organization.photos[0].full
        }
        name.text = organization.name
        missionStatement.text = organization.mission_statement ?? "No mission statement available"
        distance.text = "Distance: " + (organization.distance == nil ? "Not available" : "\(organization.distance!)")

        let email = organization.email ?? ""
        let phone = organization.phone ?? ""
        let website = organization.website ?? ""
        let street = organization.address.address1 ?? ""
        let city = organization.address.city ?? ""
        let state = organization.address.state ?? ""

        var address: String = ""
        address = address + (street.isEmpty ? "" : street + ", ")
        address = address + (city.isEmpty ? "" : city + " ")
        address = address + (state.isEmpty ? "" : state)

        var contactInfo: String = ""
        contactInfo = contactInfo + (email.isEmpty ? "" : "Email: " + email + "\n")
        contactInfo = contactInfo + (phone.isEmpty ? "" : "Phone: " + phone + "\n")
        contactInfo = contactInfo + (website.isEmpty ? "" : "Website: " + website + "\n")
        contactInfo = contactInfo + (address.isEmpty ? "" : "Address: " + address)
        contact.text = contactInfo.isEmpty ? "No contact information available" : contactInfo
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "organizationToAnimalSearchResult" {
            if let animalSearchResultCollectionViewController = segue.destination as? AnimalSearchResultCollectionViewController {
                animalSearchResultCollectionViewController.searchParams = AnimalSearchParams(organizationId: organization.id)
                animalSearchResultCollectionViewController.shouldShowHeader = false
                animalSearchResultCollectionViewController.shouldAllowFilters = false
             }
        }
    }
}
