import XCTest

class HomePageUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUp() {
        app.launchArguments.append("UI_TESTING")
        continueAfterFailure = false
        app.launch()
    }

    func testShouldDisplaySearchByLocationFormWhenLocationButtonIsPressed() {
        app.buttons["locationButton"].tap()
        XCTAssertEqual(app.navigationBars.element.identifier, "FurEver.SearchByLocationFormView")
    }

    func testShouldDisplaySearchByOrganizationFormWhenOrganizationButtonIsPressed() {
        app.buttons["organizationButton"].tap()
        XCTAssertEqual(app.navigationBars.element.identifier, "FurEver.SearchByOrganizationFormView")
    }

    func testShouldNavigateToCorrectFormsWhenTabBarButtonsAreTapped() {
        app/*@START_MENU_TOKEN@*/.buttons["locationButton"]/*[[".buttons[\"cat\"]",".buttons[\"locationButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.tabBars.buttons["Search by Organization"].tap()
        XCTAssertEqual(app.navigationBars.element.identifier, "FurEver.SearchByOrganizationFormView")

        app.tabBars.buttons["Search by Location"].tap()
        XCTAssertEqual(app.navigationBars.element.identifier, "FurEver.SearchByLocationFormView")

        app.tabBars.buttons["Info"].tap()
        XCTAssert(app.images["fureverLogo"].exists)
    }
}
