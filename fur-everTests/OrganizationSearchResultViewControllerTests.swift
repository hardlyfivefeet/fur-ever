import XCTest
@testable import FurEver

class OrganizationSearchResultViewControllerTests: XCTestCase {

    override func setUp() {
    }

    override func tearDown() {
    }

    func testShouldDisplayCorrectOrganizationWhenOrganizationSearchResultViewControllerLoads() {
        guard let organizationSearchResultViewController = UIStoryboard(name: "Main", bundle: nil)
                       .instantiateViewController(withIdentifier: "organizationSearchResultViewController")
                       as? OrganizationSearchResultViewController else {
           XCTFail()
           return
        }

        organizationSearchResultViewController.organization = Organization(id: "0001", name: "Pacific Pups Rescue", email: "pacificpupsrescue@gmail.com", phone: "012-345-6789", website: "http://pacificpupsrescue.org", address: Address(city: "Sacramento", state: "CA"), photos: [Photo(full: "https://s3.amazonaws.com/petfinder-us-east-1-petimages-prod/organization-photos/46947/46947-1.jpg?bust=2017-11-29+07%3A54%3A33")], mission_statement: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")

        guard let _ = organizationSearchResultViewController.view else {
            XCTFail()
            return
        }

        organizationSearchResultViewController.viewDidLoad()
        XCTAssertEqual(organizationSearchResultViewController.name.text, "Pacific Pups Rescue")
        XCTAssertEqual(organizationSearchResultViewController.image.imageURL, "https://s3.amazonaws.com/petfinder-us-east-1-petimages-prod/organization-photos/46947/46947-1.jpg?bust=2017-11-29+07%3A54%3A33")
        XCTAssertEqual(organizationSearchResultViewController.missionStatement.text, "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
        XCTAssertNotNil(organizationSearchResultViewController.distance!.text)
        XCTAssertNotNil(organizationSearchResultViewController.contact!.text)
    }

}
