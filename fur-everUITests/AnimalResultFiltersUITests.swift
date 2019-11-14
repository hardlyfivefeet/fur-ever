import XCTest

class AnimalResultFiltersUITests: XCTestCase {

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
        app.buttons["searchButton"].tap()
        app.navigationBars.buttons["Filters"].tap()
    }

    func testSegmentedControlsShouldChangeWhenTapped() {
        XCTAssertTrue(app.segmentedControls.buttons["Dog"].isSelected)
        XCTAssertTrue(app.segmentedControls.buttons["100 mi"].isSelected)

        app.segmentedControls.buttons["Cat"].tap()
        XCTAssertTrue(app.segmentedControls.buttons["Cat"].isSelected)

        app.segmentedControls.buttons["Bird"].tap()
        XCTAssertTrue(app.segmentedControls.buttons["Bird"].isSelected)

        app.segmentedControls.buttons["Rabbit"].tap()
        XCTAssertTrue(app.segmentedControls.buttons["Rabbit"].isSelected)

        app.segmentedControls.buttons["10 mi"].tap()
        XCTAssertTrue(app.segmentedControls.buttons["10 mi"].isSelected)

        app.segmentedControls.buttons["25 mi"].tap()
        XCTAssertTrue(app.segmentedControls.buttons["25 mi"].isSelected)

        app.segmentedControls.buttons["50 mi"].tap()
        XCTAssertTrue(app.segmentedControls.buttons["50 mi"].isSelected)
    }

    func testShouldReturnToSearchResultsWhenCancelButtonIsTapped() {
        app.buttons["Cancel"].tap()
        XCTAssertTrue(app.navigationBars.buttons["Filters"].isHittable)
        XCTAssert(!app.staticTexts["Select"].exists)
    }

    func testShouldReturnToSearchResultsWhenApplyFiltersButtonIsTapped() {
        app.buttons["Apply Filters"].tap()
        XCTAssertTrue(app.navigationBars.buttons["Filters"].isHittable)
        XCTAssert(!app.staticTexts["Select"].exists)
    }

    func testShouldPopulateTableWithValuesWhenSelectButtonIsTapped() {
        let selectButton = app.buttons.matching(identifier: "breedFilter").element(boundBy: 0)
        selectButton.tap()

        let tableView = app.tables.element
        let cell = tableView.cells.element(boundBy: 0)
        XCTAssertNotNil(cell)
    }

    func testFilterLabelShouldChangeWhenAppliedFilterIsSaved() {
        testShouldPopulateTableWithValuesWhenSelectButtonIsTapped()
        let tableView = app.tables.element
        let cell = tableView.cells.element(boundBy: 0)
        cell.tap()
        let saveButton = app.buttons["Save"]
        saveButton.tap()
        XCTAssert(app.staticTexts["1 selected"].exists)
    }

    func testRowShouldRemainSelectedAfterAppliedFilterIsSaved() {
        testFilterLabelShouldChangeWhenAppliedFilterIsSaved()
        let selectButton = app.buttons.matching(identifier: "breedFilter").element(boundBy: 0)
        selectButton.tap()
        XCTAssertTrue(app.tables.cells.element(boundBy: 0).isSelected)
    }

    func testClearAllShouldResetFilterLabels() {
        testFilterLabelShouldChangeWhenAppliedFilterIsSaved()
        let clearButton = app.buttons["Clear All"]
        clearButton.tap()
        XCTAssert(!app.staticTexts["1 selected"].exists)
    }

    func testFilterLabelsShouldNotChangeWhenAppliedFilterIsCancelled() {
        testRowShouldRemainSelectedAfterAppliedFilterIsSaved()
        let tableView = app.tables.element
        let cell = tableView.cells.element(boundBy: 1)
        cell.tap()

        let cancelButton = app.buttons.matching(identifier: "cancelFilterSelection").element(boundBy: 0)
        cancelButton.tap()
        XCTAssert(app.staticTexts["1 selected"].exists)
        XCTAssert(!app.staticTexts["2 selected"].exists)
    }
}
