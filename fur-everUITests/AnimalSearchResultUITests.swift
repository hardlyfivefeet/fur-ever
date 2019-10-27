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

    func testShouldDisplayViewWhenSearchResultIsTapped() {
        let collectionView = app.collectionViews.element
        let cell = collectionView.cells.element(boundBy: 0)
        XCTAssertNotNil(cell)
        cell.tap()

        XCTAssertNotNil(app.staticTexts["animalName"])
        XCTAssert(app.images["animalImage"].exists)
    }
    
    func testShouldScrollToBottomOfTextField() {
        let collectionView = app.collectionViews.element
        let cell = collectionView.cells.element(boundBy: 0)
        cell.tap()
        
        let scroll = app.scrollViews.element
        let contact = app.staticTexts["contact"]
        scroll.swipeUp()
        XCTAssertTrue(contact.isHittable)
    }
}
