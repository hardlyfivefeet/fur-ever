import XCTest

class AnimalSearchResultUITests: XCTestCase {

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
    }

    func testShouldDisableReturnKeyWhenSearchBarIsEmpty() {
        let searchBar = app.searchFields.element
        searchBar.tap()
        let searchText = searchBar.value as? String ?? ""
        let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: searchText.count)
        searchBar.typeText(deleteString)

        XCTAssert(!app.buttons["search"].isEnabled)
    }

    func testShouldEnableReturnKeyWhenSearchBarIsNotEmpty() {
        testShouldDisableReturnKeyWhenSearchBarIsEmpty()
        app.searchFields.element.typeText("woohoo tests")
        XCTAssert(app.buttons["search"].isEnabled)
    }

    func testTappingOnReturnKeyOnSearchBarShouldPopulateCollectionView() {
        testShouldEnableReturnKeyWhenSearchBarIsNotEmpty()
        app.buttons["search"].tap()

        let collectionView = app.collectionViews.element
        XCTAssertTrue(collectionView.exists)
        XCTAssertEqual(1, collectionView.children(matching: .cell).count)
    }

    func testShouldDisplayViewWhenSearchResultIsTapped() {
        let collectionView = app.collectionViews.element
        let cell = collectionView.cells.element(boundBy: 0)
        XCTAssertNotNil(cell)
        cell.tap()

        XCTAssertNotNil(app.staticTexts["animalName"])
        XCTAssert(app.images["animalImage"].exists)
    }

    func testShouldScrollToBottomOfTextFieldInIndividualResultView() {
        let collectionView = app.collectionViews.element
        collectionView.cells.element(boundBy: 0).tap()

        let scroll = app.scrollViews.element
        let contact = app.staticTexts["contact"]
        scroll.swipeUp()
        XCTAssertTrue(contact.isHittable)
    }

    func testShouldLeaveResultPageWhenReadMoreButtonIsTapped() {
        testShouldScrollToBottomOfTextFieldInIndividualResultView()
        app.buttons["Read More"].tap()
        XCTAssertFalse(app.buttons["Read More"].isHittable)
    }

    func testShouldDisplayAlertIfWebsiteURLIsEmpty() {
        testShouldLeaveResultPageWhenReadMoreButtonIsTapped()
        XCTAssertEqual(app.alerts.element.label, "URL not found")
    }

    func testShouldReturnToResultPageIfWebsiteURLIsEmpty() {
        testShouldDisplayAlertIfWebsiteURLIsEmpty()
        app.alerts.element.buttons["Acknowledge"].tap()
        XCTAssertNotNil(app.staticTexts["animalName"])
        XCTAssert(app.images["animalImage"].exists)
    }
}
