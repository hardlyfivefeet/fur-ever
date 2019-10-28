import XCTest
@testable import FurEver

class OrganizationSearchResultViewControllerTests: XCTestCase {

    override func setUp() {
    }

    override func tearDown() {
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
