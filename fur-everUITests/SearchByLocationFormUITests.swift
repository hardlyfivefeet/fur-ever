import XCTest

class SearchByLocationFormUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUp() {
        app.launchArguments.append("UI_TESTING")
        continueAfterFailure = false
        app.launch()
        app.buttons["locationButton"].tap()
    }

    func testAppShouldStartWithAnEmptySearchField() {
        let locationField = app.textFields["locationField"]
        XCTAssertEqual(locationField.value as? String ?? "", "Zip Code/City, State")
    }

    func testAppShouldStartWithADisabledSearchButton() {
        let searchButton = app.buttons["searchButton"]
        XCTAssert(!searchButton.isEnabled)
    }

    func testSegmentedControlsShouldChangeWhenTapped() {
        XCTAssertTrue(app.segmentedControls.buttons["Dog"].isSelected)

        app.segmentedControls.buttons["Cat"].tap()
        XCTAssertTrue(app.segmentedControls.buttons["Cat"].isSelected)

        app.segmentedControls.buttons["Bird"].tap()
        XCTAssertTrue(app.segmentedControls.buttons["Bird"].isSelected)

        app.segmentedControls.buttons["Rabbit"].tap()
        XCTAssertTrue(app.segmentedControls.buttons["Rabbit"].isSelected)
    }

    func testSearchButtonShouldBeEnabledWhenTheSearchFieldIsNotBlank() {
        let locationField = app.textFields["locationField"]
        locationField.tap()
        locationField.typeText("testy test")

        let searchButton = app.buttons["searchButton"]
        XCTAssert(searchButton.isEnabled)
    }

    func testSearchButtonShouldBeDisabledWhenTheSearchFieldIsBlank() {
    testSearchButtonShouldBeEnabledWhenTheSearchFieldIsNotBlank()

        let locationField = app.textFields["locationField"]
        let searchText = locationField.value as? String ?? ""
        let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: searchText.count)
        locationField.typeText(deleteString)

        let searchButton = app.buttons["searchButton"]
        XCTAssert(!searchButton.isEnabled)
    }

    func testShouldPopulateTheCollectionViewWhenSearchResultsArrive() {
        let locationField = app.textFields["locationField"]
        locationField.tap()
        locationField.typeText("testy testy")

        app.buttons["done"].tap()

        let searchButton = app.buttons["searchButton"]
        searchButton.tap()

        let collectionView = app.collectionViews.element
        XCTAssertTrue(collectionView.exists)
        XCTAssertEqual(1, collectionView.children(matching: .cell).count)
    }
}
