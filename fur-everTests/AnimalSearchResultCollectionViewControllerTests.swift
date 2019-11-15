import XCTest
@testable import FurEver

class AnimalSearchResultCollectionViewControllerTests: XCTestCase {

    var viewControllerUnderTest: AnimalSearchResultCollectionViewController!

    override func setUp() {
        super.setUp()

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.viewControllerUnderTest = storyboard.instantiateViewController(withIdentifier: "animalSearchResultCollectionViewController") as? AnimalSearchResultCollectionViewController
    }

    func testShouldReturnTheCorrectNumberOfSectionsAndItems() {

        viewControllerUnderTest.api = MockApiService()
        guard let collectionView = viewControllerUnderTest.collectionView else {
            XCTFail()
            return
        }
        XCTAssertEqual(1, viewControllerUnderTest.numberOfSections(in: collectionView))
        XCTAssertEqual(1, viewControllerUnderTest.collectionView(collectionView, numberOfItemsInSection: 0))
    }

    func testShouldAlwaysAllowItemSelection() {
        viewControllerUnderTest.api = MockApiService()
        XCTAssert(viewControllerUnderTest.collectionView(
            viewControllerUnderTest.collectionView, shouldSelectItemAt: IndexPath(row: 5, section: 0)))
    }

    func testShouldTriggerPetfinderSearchWhenAnimalSearchResultCollectionViewControllerLoads() {
        viewControllerUnderTest.api = TestApiService()
        viewControllerUnderTest.searchParams = AnimalSearchParams("Dog", "Los Angeles")
        viewControllerUnderTest.viewDidLoad()
    }

    func testShouldDisplayAlertWhenAPICallFails() {
        var failureCallbackWasCalled = false
        viewControllerUnderTest.failureCallback = { _ in failureCallbackWasCalled = true }

        viewControllerUnderTest.api = FailingApiService()
        viewControllerUnderTest.searchParams = AnimalSearchParams("Dog", "Los Angeles")
        viewControllerUnderTest.viewDidLoad()

        XCTAssert(failureCallbackWasCalled)
    }
}
