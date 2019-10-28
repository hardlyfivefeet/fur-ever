import XCTest
@testable import FurEver

class OrganizationSearchResultViewControllerTests: XCTestCase {

    override func setUp() {
    }

    override func tearDown() {
    }
    
    func testShouldDisplayCorrectOrganizationWhenOrgnaizationSearchResultViewControllerLoads() {
        guard let organizationSearchResultViewController = UIStoryboard(name: "Main", bundle: nil)
                       .instantiateViewController(withIdentifier: "organizationSearchResultViewController")
                       as? OrganizationSearchResultViewController else {
           XCTFail()
           return
        }

        organizationSearchResultViewController.organizationId = "0001"

        guard let _ = organizationSearchResultViewController.view else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(organizationSearchResultViewController.name.text, "Silky Terrier Rescue Charitable Trust Charity")
        XCTAssertEqual(organizationSearchResultViewController.image.imageURL, "https://s3.amazonaws.com/petfinder-us-east-1-petimages-prod/organization-photos/27452/27452-1.jpg?bust=2017-07-23+19%3A42%3A27")
        XCTAssertEqual(organizationSearchResultViewController.missionStatement.text, "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
        XCTAssertNotNil(organizationSearchResultViewController.distance!.text)
        XCTAssertNotNil(organizationSearchResultViewController.contact!.text)
    }

    func testShouldTriggerPetfinderSearchWhenOrganizationSearchResultViewControllerLoads() {
        guard let organizationSearchResultViewController = UIStoryboard(name: "Main", bundle: nil)
                       .instantiateViewController(withIdentifier: "organizationSearchResultViewController")
                       as? OrganizationSearchResultViewController else {
            XCTFail()
            return
        }

        organizationSearchResultViewController.api = TestApiService()
        organizationSearchResultViewController.organizationId = "test123"
        organizationSearchResultViewController.viewDidLoad()
    }

    func testShouldDisplayAlertWhenAPICallFails() {
        guard let organizationSearchResultViewController = UIStoryboard(name: "Main", bundle: nil)
                       .instantiateViewController(withIdentifier: "organizationSearchResultViewController")
                       as? OrganizationSearchResultViewController else {
            XCTFail()
            return
        }
        var failureCallbackWasCalled = false
        organizationSearchResultViewController.failureCallback = { _ in failureCallbackWasCalled = true }

        organizationSearchResultViewController.api = FailingApiService()
        organizationSearchResultViewController.organizationId = "test123"
        organizationSearchResultViewController.viewDidLoad()

        XCTAssert(failureCallbackWasCalled)
    }
}
