import XCTest

class InfoPageUITests: XCTestCase {
    
    let app = XCUIApplication()

    override func setUp() {
        app.launchArguments.append("UI_TESTING")
        continueAfterFailure = false
        app.launch()
        app.buttons["locationButton"].tap()
        app.tabBars.buttons["Info"].tap()
    }

    override func tearDown() {
    }

    func testShouldLeaveAppWhenPetfinderLinkButtonIsTapped() {
        app.buttons["petfinderLink"].tap()
        XCTAssertFalse(app.buttons["petfinderLink"].isHittable)
    }
    
    func testShouldSeeAllTextWhenInfoPageLoads() {
        let contactText = app.staticTexts["contactText"]
        let logo = app.images["fureverLogo"]

        XCTAssertTrue(contactText.isHittable)
        XCTAssert(logo.exists)
    }

}
