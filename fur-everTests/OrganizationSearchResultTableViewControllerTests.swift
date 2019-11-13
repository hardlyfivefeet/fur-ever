import XCTest
@testable import FurEver

class OrganizationSearchResultTableViewControllerTests: XCTestCase {

    func testShouldReturnTheCorrectNumberOfSectionsAndItems() {
        guard let organizationSearchResultTableViewController = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(withIdentifier: "organizationSearchResultTableViewController")
                as? OrganizationSearchResultTableViewController else {
            XCTFail()
            return
        }
        guard let tableView = organizationSearchResultTableViewController.tableView else {
            XCTFail()
            return
        }
        XCTAssertEqual(1, organizationSearchResultTableViewController.numberOfSections(in: tableView))
        XCTAssertEqual(2, organizationSearchResultTableViewController.tableView(tableView, numberOfRowsInSection: 0))
    }

    func testShouldAlwaysAllowRowSelection() {
        guard let organizationSearchResultTableViewController = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(withIdentifier: "organizationSearchResultTableViewController")
                as? OrganizationSearchResultTableViewController else {
            XCTFail()
            return
        }
        XCTAssertNotNil(organizationSearchResultTableViewController.tableView(organizationSearchResultTableViewController.tableView, willSelectRowAt: IndexPath(row: 5, section: 0)))
    }

    func testShouldTriggerPetfinderSearchWhenOrganizationSearchResultTableViewControllerLoads() {
        guard let organizationSearchResultTableViewController = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(withIdentifier: "organizationSearchResultTableViewController")
                as? OrganizationSearchResultTableViewController else {
            XCTFail()
            return
        }

        organizationSearchResultTableViewController.api = TestApiService()
        organizationSearchResultTableViewController.searchParams = OrganizationSearchParams(name: "Petspace", location: "Anaheim")
        organizationSearchResultTableViewController.viewDidLoad()
    }

    func testShouldDisplayAlertWhenAPICallFails() {
        guard let organizationSearchResultTableViewController = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(withIdentifier: "organizationSearchResultTableViewController")
                as? OrganizationSearchResultTableViewController else {
            XCTFail()
            return
        }

        var failureCallbackWasCalled = false
        organizationSearchResultTableViewController.failureCallback = { _ in failureCallbackWasCalled = true }

        organizationSearchResultTableViewController.api = FailingApiService()
        organizationSearchResultTableViewController.searchParams = OrganizationSearchParams(name: "Petspace", location: "Anaheim")
        organizationSearchResultTableViewController.viewDidLoad()

        XCTAssert(failureCallbackWasCalled)
    }
}
