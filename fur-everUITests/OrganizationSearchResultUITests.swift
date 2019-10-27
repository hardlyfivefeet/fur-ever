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
        let cell = tableView.cells.element(boundBy: 0).tap()

//        let webView = app.webViews["resultWebView"]
//        XCTAssert(webView.exists)
    }
    
    func testShouldNavigateToAnimalSearchResultCollectionViewWhenButtonIsTapped() {
        
    }
    
    func testShouldScrollToBottomOfTextField() {
        
    }

}
