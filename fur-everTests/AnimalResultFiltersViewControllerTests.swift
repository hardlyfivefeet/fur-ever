import XCTest
@testable import FurEver

class AnimalResultFiltersViewControllerTests: XCTestCase {

    var viewControllerUnderTest: AnimalResultFiltersViewController!
    let originalParams = AnimalSearchParams("Cat", "Los Angeles")

    override func setUp() {
        super.setUp()

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.viewControllerUnderTest = storyboard.instantiateViewController(withIdentifier: "animalResultFiltersViewController") as? AnimalResultFiltersViewController

        viewControllerUnderTest.searchParams = originalParams
        self.viewControllerUnderTest.loadView()
        self.viewControllerUnderTest.viewDidLoad()
    }

    func testSearchParamsCopyShouldNotBeChanged() {
        viewControllerUnderTest.searchParams = AnimalSearchParams("Dog", "Irvine")
        XCTAssertNotEqual(viewControllerUnderTest.searchParams, originalParams)
        XCTAssertNotEqual(viewControllerUnderTest.searchParams, viewControllerUnderTest.searchParamsCopy)
        XCTAssertEqual(viewControllerUnderTest.searchParamsCopy, originalParams)
    }

}
