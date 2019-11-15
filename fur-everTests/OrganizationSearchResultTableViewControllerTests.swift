import XCTest
@testable import FurEver

class OrganizationSearchResultTableViewControllerTests: XCTestCase {

    var viewControllerUnderTest: OrganizationSearchResultTableViewController!

    override func setUp() {
        super.setUp()

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.viewControllerUnderTest = storyboard.instantiateViewController(withIdentifier: "organizationSearchResultTableViewController") as? OrganizationSearchResultTableViewController
    }

    func testHasATableView() {
        viewControllerUnderTest.api = MockApiService()
        viewControllerUnderTest.viewDidLoad()
        XCTAssertNotNil(viewControllerUnderTest.tableView)
    }

    func testTableViewHasDelegate() {
        viewControllerUnderTest.api = MockApiService()
        viewControllerUnderTest.viewDidLoad()
        XCTAssertNotNil(viewControllerUnderTest.tableView.delegate)
    }

    func testTableViewConfromsToTableViewDelegateProtocol() {
        viewControllerUnderTest.api = MockApiService()
        viewControllerUnderTest.viewDidLoad()
        XCTAssertTrue(viewControllerUnderTest.conforms(to: UITableViewDelegate.self))
        XCTAssertTrue(viewControllerUnderTest.responds(to: #selector(viewControllerUnderTest.tableView(_:didSelectRowAt:))))
    }

    func testTableViewHasDataSource() {
        viewControllerUnderTest.api = MockApiService()
        viewControllerUnderTest.viewDidLoad()
        XCTAssertNotNil(viewControllerUnderTest.tableView.dataSource)
    }

    func testTableViewConformsToTableViewDataSourceProtocol() {
        viewControllerUnderTest.api = MockApiService()
        viewControllerUnderTest.viewDidLoad()
        XCTAssertTrue(viewControllerUnderTest.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(viewControllerUnderTest.responds(to: #selector(viewControllerUnderTest.numberOfSections(in:))))
        XCTAssertTrue(viewControllerUnderTest.responds(to: #selector(viewControllerUnderTest.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(viewControllerUnderTest.responds(to: #selector(viewControllerUnderTest.tableView(_:cellForRowAt:))))
    }

    func testTableViewCellHasReuseIdentifier() {
        viewControllerUnderTest.api = MockApiService()
        viewControllerUnderTest.viewDidLoad()
        let cell = viewControllerUnderTest.tableView(viewControllerUnderTest.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? OrganizationSearchResultTableViewCell
        let actualReuseIdentifer = cell?.reuseIdentifier
        let expectedReuseIdentifier = "organizationTableCell"
        XCTAssertEqual(actualReuseIdentifer, expectedReuseIdentifier)
    }

    func testShouldReturnTheCorrectNumberOfSectionsAndItems() {
        viewControllerUnderTest.api = MockApiService()
        guard let tableView = viewControllerUnderTest.tableView else {
            XCTFail()
            return
        }
        XCTAssertEqual(1, viewControllerUnderTest.numberOfSections(in: tableView))
        XCTAssertEqual(1, viewControllerUnderTest.tableView(tableView, numberOfRowsInSection: 0))
    }

    func testTableCellHasCorrectText() {
        viewControllerUnderTest.api = MockApiService()
        viewControllerUnderTest.viewDidLoad()

        let cell0 = viewControllerUnderTest.tableView(viewControllerUnderTest.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? OrganizationSearchResultTableViewCell
        XCTAssertEqual(cell0?.organizationName.text, "Pacific Pups Rescue")
    }

    func testShouldAlwaysAllowRowSelection() {
        viewControllerUnderTest.api = MockApiService()
        XCTAssertNotNil(viewControllerUnderTest.tableView(viewControllerUnderTest.tableView, willSelectRowAt: IndexPath(row: 5, section: 0)))
    }

    func testShouldTriggerPetfinderSearchWhenOrganizationSearchResultTableViewControllerLoads() {
        viewControllerUnderTest.api = TestApiService()
        viewControllerUnderTest.searchParams = OrganizationSearchParams(name: "Petspace", location: "Anaheim")
        viewControllerUnderTest.viewDidLoad()
    }

    func testShouldDisplayAlertWhenAPICallFails() {
        var failureCallbackWasCalled = false
        viewControllerUnderTest.failureCallback = { _ in failureCallbackWasCalled = true }

        viewControllerUnderTest.api = FailingApiService()
        viewControllerUnderTest.searchParams = OrganizationSearchParams(name: "Petspace", location: "Anaheim")
        viewControllerUnderTest.viewDidLoad()

        XCTAssert(failureCallbackWasCalled)
    }
}
