import Foundation
import UIKit
import SiestaUI

class OrganizationSearchResultViewController: UIViewController {

    var api: Api = ProcessInfo.processInfo.arguments.contains(TESTING_UI) ?
           MockApiService() : ApiService()
    var failureCallback: ((Error) -> Void)?

    var organization: Organization!
    var organizationId: String!

    @IBOutlet weak var image: RemoteImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var distance: UITextView!
    @IBOutlet weak var missionStatement: UITextView!
    @IBOutlet weak var contact: UITextView!

    @IBOutlet weak var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        api.api(host: "https://api.petfinder.com/v2/")
        api.getOrganization(with: organizationId, then: display, fail: failureCallback ?? report)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollView.flashScrollIndicators()
    }

    private func display(selectedOrganization: Organization) {
        organization = selectedOrganization
        image.imageURL = organization.image.url
        name.text = organization.basicInfo.name
        missionStatement.text = organization.missionStatement
        distance.text = "Distance: " + (organization.distance == nil ? "Not available" : "\(organization.distance!)")

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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "organizationToAnimalSearchResult" {
            if let animalSearchResultCollectionViewController = segue.destination as? AnimalSearchResultCollectionViewController {
                animalSearchResultCollectionViewController.searchParams = AnimalSearchParams(organizationId: organizationId)
                animalSearchResultCollectionViewController.shouldShowHeader = false
                animalSearchResultCollectionViewController.shouldAllowFilters = false
             }
        }
    }

    private func report(error: Error) {
        let alert = UIAlertController(title: "Network Issue",
           message: "Sorry, we seem to have encountered a network problem: \(error.localizedDescription)",
           preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Acknowledge", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
