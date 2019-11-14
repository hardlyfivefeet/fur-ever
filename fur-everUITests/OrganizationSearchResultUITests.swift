import XCTest

class OrganizationSearchResultUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUp() {
        app.launchArguments.append("UI_TESTING")
        continueAfterFailure = false
        app.launch()
        app.buttons["organizationButton"].tap()

        let locationField = app.textFields["locationField"]
        locationField.tap()
        locationField.typeText("testy test")

        app.buttons["done"].tap()
        app.buttons["searchButton"].tap()
    }

    func testShouldDisplayViewWhenSearchResultIsTapped() {
        let tableView = app.tables.element
        let cell = tableView.cells.element(boundBy: 0)
        XCTAssertNotNil(cell)
        cell.tap()

        XCTAssertNotNil(app.staticTexts["organizationName"])
        XCTAssert(app.images["organizationImage"].exists)
    }

    func testShouldNavigateToAnimalSearchResultCollectionViewWhenButtonIsTapped() {
        testShouldDisplayViewWhenSearchResultIsTapped()

        app.buttons["getPetsButton"].tap()
        let collectionView = app.collectionViews.element
        XCTAssertTrue(collectionView.exists)
        XCTAssertEqual(1, collectionView.children(matching: .cell).count)
    }

    func testShouldScrollToBottomOfTextFieldInIndividualResultView() {
        let tableView = app.tables.element
        tableView.cells.element(boundBy: 0).tap()
        let scroll = app.scrollViews.element
        let contact = app.staticTexts["contact"]
        scroll.swipeUp()
        XCTAssertTrue(contact.isHittable)
    }

    func testShouldNavigateToWebsiteWhenReadMoreButtonIsTapped() {
        testShouldScrollToBottomOfTextFieldInIndividualResultView()
        app.buttons["Read More"].tap()
        XCTAssertFalse(app.buttons["Read More"].isHittable)
    }

    func testShouldDisplayAlertIfWebsiteURLIsEmpty() {
        testShouldNavigateToWebsiteWhenReadMoreButtonIsTapped()
        XCTAssertEqual(app.alerts.element.label, "URL not found")
    }

    func testShouldReturnToResultPageIfWebsiteURLIsEmpty() {
        testShouldDisplayAlertIfWebsiteURLIsEmpty()
        app.alerts.element.buttons["Acknowledge"].tap()
        XCTAssertNotNil(app.staticTexts["organizationName"])
        XCTAssert(app.images["organizationImage"].exists)
    }
}
