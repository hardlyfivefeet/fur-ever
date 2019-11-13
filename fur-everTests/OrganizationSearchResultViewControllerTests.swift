import XCTest
@testable import FurEver

class OrganizationSearchResultViewControllerTests: XCTestCase {

    func testShouldDisplayCorrectOrganizationWhenOrganizationSearchResultViewControllerLoads() {
        guard let organizationSearchResultViewController = UIStoryboard(name: "Main", bundle: nil)
                       .instantiateViewController(withIdentifier: "organizationSearchResultViewController")
                       as? OrganizationSearchResultViewController else {
           XCTFail()
           return
        }

        organizationSearchResultViewController.organization = Organization(id: "0001", name: "Pacific Pups Rescue", email: "pacificpupsrescue@gmail.com", phone: "012-345-6789", website: "http://pacificpupsrescue.org", address: Address(city: "Sacramento", state: "CA"), photos: [Photo(medium: "https://s3.amazonaws.com/petfinder-us-east-1-petimages-prod/organization-photos/46947/46947-1.jpg?bust=2017-11-29+07%3A54%3A33")])

        guard let _ = organizationSearchResultViewController.view else {
            XCTFail()
            return
        }

        organizationSearchResultViewController.viewDidLoad()
        XCTAssertEqual(organizationSearchResultViewController.name.text, "Pacific Pups Rescue")
        XCTAssertEqual(organizationSearchResultViewController.image.imageURL, "https://s3.amazonaws.com/petfinder-us-east-1-petimages-prod/organization-photos/46947/46947-1.jpg?bust=2017-11-29+07%3A54%3A33")
        XCTAssertNotNil(organizationSearchResultViewController.distance!.text)
        XCTAssertNotNil(organizationSearchResultViewController.contact!.text)
    }
}
