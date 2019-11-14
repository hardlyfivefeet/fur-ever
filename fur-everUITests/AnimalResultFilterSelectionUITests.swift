import XCTest

class AnimalResultFilterSelectionUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUp() {
        app.launchArguments.append("UI_TESTING")
        continueAfterFailure = false
        app.launch()

        app.buttons["locationButton"].tap()
        let locationField = app.textFields["locationField"]
        locationField.tap()
        locationField.typeText("testy test")
        app.buttons["done"].tap()
        let searchButton = app.buttons["searchButton"]
        searchButton.tap()

        let filterButton = app.navigationBars.buttons["Filters"]
        filterButton.tap()
    }

    func testShouldReturnToPreviousControllerWhenSaveButtonIsTapped() {
        let selectButton = app.buttons.matching(identifier: "breedFilter").element(boundBy: 0)
        selectButton.tap()
        let saveButton = app.buttons.matching(identifier: "saveFilterSelection").element(boundBy: 0)
        saveButton.tap()

        XCTAssert(app.staticTexts["Select"].exists)
        XCTAssert(!app.staticTexts["Affenpinscher"].exists)
    }

    func testShouldReturnToPreviousControllerWhenCancelButtonIsTapped() {
        let selectButton = app.buttons.matching(identifier: "breedFilter").element(boundBy: 0)
        selectButton.tap()
        let cancelButton = app.buttons.matching(identifier: "cancelFilterSelection").element(boundBy: 0)
        cancelButton.tap()

        XCTAssert(app.staticTexts["Select"].exists)
        XCTAssert(!app.staticTexts["Affenpinscher"].exists)
    }
}
