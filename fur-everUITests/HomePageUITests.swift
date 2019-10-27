import XCTest

class HomePageUITests: XCTestCase {
    
    let app = XCUIApplication()

    override func setUp() {
        app.launchArguments.append("UI_TESTING")
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    func testShouldDisplaySearchByLocationFormWhenLocationButtonIsPressed() {
        XCUIApplication()/*@START_MENU_TOKEN@*/.buttons["locationButton"]/*[[".buttons[\"cat\"]",".buttons[\"locationButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCTAssertEqual(app.navigationBars.element.identifier, "FurEver.SearchByLocationFormView")

    }
    
    func testShouldDisplaySearchByOrganizationFormWhenOrganizationButtonIsPressed() {
        XCUIApplication().buttons["organizationButton"].tap()
        XCTAssertEqual(app.navigationBars.element.identifier, "FurEver.SearchByOrganizationFormView")

    }
}
