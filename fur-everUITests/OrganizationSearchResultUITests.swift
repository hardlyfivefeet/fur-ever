import XCTest

class OrganizationSearchResultUITests: XCTestCase {
    
    let app = XCUIApplication()

    override func setUp() {
        app.launchArguments.append("UI_TESTING")
        continueAfterFailure = false
        app.launch()
        XCUIApplication().buttons["organizationButton"].tap()
        
        let locationField = app.textFields["locationField"]
        locationField.tap()
        locationField.typeText("testy test")

        app.buttons["done"].tap()

        let searchButton = app.buttons["searchButton"]
        searchButton.tap()
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
        
    }
    
    func testShouldScrollToBottomOfTextField() {
        let tableView = app.tables.element
        let cell = tableView.cells.element(boundBy: 0)
        cell.tap()
        
        let scroll = app.scrollViews.element
        let contact = app.staticTexts["contact"]
        scroll.swipeUp()
        XCTAssertTrue(contact.isHittable)
    }

}
