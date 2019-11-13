import XCTest

class WebViewUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUp() {
        app.launchArguments.append("UI_TESTING")
        continueAfterFailure = false
        app.launch()
    }

    func testShouldDisplayAlertIfWebsiteURLIsEmpty() {}

    func testShouldReturnToAnimalResultPageIfWebsiteURLIsEmpty() {}

    func testShouldReturnToOrganizationResultPageIfWebsiteURLIsEmpty() {}
}
