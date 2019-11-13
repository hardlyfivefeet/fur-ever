import XCTest

class AnimalResultFiltersUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUp() {
        app.launchArguments.append("UI_TESTING")
        continueAfterFailure = false
        app.launch()
    }

    func testSegmentedControlsShouldChangeWhenTapped() {}

    func testClearAllShouldResetFilterLabels() {}

    func testShouldReturnToSearchResultsWhenCancelButtonIsTapped() {}

    func testShouldReturnToSearchResultsWhenApplyFiltersButtonIsTapped() {}

    func testShouldPopulateTableWithValuesWhenSelectButtonIsTapped() {}

}
