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

        let searchButton = app.buttons["searchButton"]
        searchButton.tap()
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
        let searchBar = app.searchFields.element
        searchBar.typeText("woohoo tests")
        
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
        let cell = collectionView.cells.element(boundBy: 0)
        cell.tap()
        
        let scroll = app.scrollViews.element
        let contact = app.staticTexts["contact"]
        scroll.swipeUp()
        XCTAssertTrue(contact.isHittable)
    }
}
