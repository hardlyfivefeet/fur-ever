import XCTest
@testable import FurEver

class OrganizationSearchResultViewControllerTests: XCTestCase {

    var viewControllerUnderTest: OrganizationSearchResultViewController!

    override func setUp() {
        super.setUp()

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.viewControllerUnderTest = storyboard.instantiateViewController(withIdentifier: "organizationSearchResultViewController") as? OrganizationSearchResultViewController
    }

    func testShouldDisplayCorrectOrganizationWhenOrganizationSearchResultViewControllerLoads() {
        viewControllerUnderTest.organization = Organization(id: "0001", name: "Pacific Pups Rescue", email: "pacificpupsrescue@gmail.com", phone: "012-345-6789", website: "http://pacificpupsrescue.org", address: Address(city: "Sacramento", state: "CA"), photos: [Photo(medium: "https://s3.amazonaws.com/petfinder-us-east-1-petimages-prod/organization-photos/46947/46947-1.jpg?bust=2017-11-29+07%3A54%3A33")])

        guard let _ = viewControllerUnderTest.view else {
            XCTFail()
            return
        }

        viewControllerUnderTest.viewDidLoad()
        XCTAssertEqual(viewControllerUnderTest.name.text, "Pacific Pups Rescue")
        XCTAssertEqual(viewControllerUnderTest.image.imageURL, "https://s3.amazonaws.com/petfinder-us-east-1-petimages-prod/organization-photos/46947/46947-1.jpg?bust=2017-11-29+07%3A54%3A33")
        XCTAssertNotNil(viewControllerUnderTest.distance!.text)
        XCTAssertNotNil(viewControllerUnderTest.contact!.text)
    }

    func testShouldDisplayCorrectEmptyInfoWhenFieldsInOrganizationResultAreNil() {
        viewControllerUnderTest.organization = Organization(id: "0001", name: "PetSpace", address: Address(), photos: [])

        guard let _ = viewControllerUnderTest.view else {
            XCTFail()
            return
        }

        viewControllerUnderTest.viewDidLoad()
        XCTAssertEqual(viewControllerUnderTest.name.text, "PetSpace")
        XCTAssertEqual(viewControllerUnderTest.image.image, UIImage(named: "NoImageAvailable"))
        XCTAssertEqual(viewControllerUnderTest.distance.text, "Distance: Not available")
        XCTAssertEqual(viewControllerUnderTest.contact.text, "No contact information available")
    }
}
