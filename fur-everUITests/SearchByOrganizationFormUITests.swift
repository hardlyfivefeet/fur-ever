import XCTest

class SearchByOrganizationFormUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUp() {
        app.launchArguments.append("UI_TESTING")
        continueAfterFailure = false
        app.launch()
        app.buttons["organizationButton"].tap()
    }

    func testAppShouldStartWithEmptySearchFields() {
        let locationField = app.textFields["locationField"]
        let nameField = app.textFields["nameField"]
        XCTAssertEqual(locationField.value as? String ?? "", "Zip Code/City, State")
        XCTAssertEqual(nameField.value as? String ?? "", "Keyword, e.g. Rescue")
    }

    func testAppShouldStartWithADisabledSearchButton() {
        let searchButton = app.buttons["searchButton"]
        XCTAssert(!searchButton.isEnabled)
    }

    func testSearchButtonShouldBeEnabledWhenLocationFieldIsNotBlank() {
        let locationField = app.textFields["locationField"]
        locationField.tap()
        locationField.typeText("testy test")

        let searchButton = app.buttons["searchButton"]
        XCTAssert(searchButton.isEnabled)
    }

    func testSearchButtonShouldBeEnabledWhenNameFieldIsNotBlank() {
        let nameField = app.textFields["nameField"]
        nameField.tap()
        nameField.typeText("testy test")

        let searchButton = app.buttons["searchButton"]
        XCTAssert(searchButton.isEnabled)
    }

    func testSearchButtonShouldBeDisabledWhenSearchFieldsAreBlank() {
        testSearchButtonShouldBeEnabledWhenLocationFieldIsNotBlank()
        testSearchButtonShouldBeEnabledWhenNameFieldIsNotBlank()

        let nameField = app.textFields["nameField"]
        let nameText = nameField.value as? String ?? ""
        var deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: nameText.count)
        nameField.typeText(deleteString)

        let locationField = app.textFields["locationField"]
        locationField.tap()
        let locationText = locationField.value as? String ?? ""
        deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: locationText.count)
        locationField.typeText(deleteString)

        let searchButton = app.buttons["searchButton"]
        XCTAssert(!searchButton.isEnabled)
    }

    func testShouldPopulateTheTableViewWhenSearchResultsArrive() {

        let nameField = app.textFields["nameField"]
        nameField.tap()
        nameField.typeText("testy test")

        let locationField = app.textFields["locationField"]
        locationField.tap()
        locationField.typeText("testy test")

        app.buttons["done"].tap()

        let searchButton = app.buttons["searchButton"]
        searchButton.tap()

        let tableView = app.tables.element
        XCTAssertTrue(tableView.exists)
        XCTAssertEqual(1, tableView.children(matching: .cell).count)
    }

}
