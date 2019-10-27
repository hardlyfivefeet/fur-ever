import XCTest

class AnimalSearchResultUITests: XCTestCase {

    let app = XCUIApplication()

    override func setUp() {
        app.launchArguments.append("UI_TESTING")
        continueAfterFailure = false
        app.launch()
        XCUIApplication().buttons["organizationButton"].tap()

        let locationField = app.textFields["locationField"]
        locationField.tap()
        locationField.typeText("testy test")

        app.buttons["done"].tap()

        let searchButton = app.buttons["searchButton"]
        searchButton.tap()
    }

    func testShouldDisplayViewWhenSearchResultIsTapped() {
        let collectionView = app.collectionViews.element
        let cell = collectionView.cells.element(boundBy: 0).tap()
    }
    
    func testShouldScrollToBottomOfTextField() {
        
    }
}
