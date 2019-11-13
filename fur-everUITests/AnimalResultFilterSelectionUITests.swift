import XCTest

class AnimalResultFilterSelectionUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUp() {
        app.launchArguments.append("UI_TESTING")
        continueAfterFailure = false
        app.launch()
    }

    func testShouldReturnToPreviousControllerWhenSaveButtonIsTapped() {}

    func testShouldReturnToPreviousControllerWhenCancelButtonIsTapped() {}
}
