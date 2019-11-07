import XCTest
@testable import FurEver

class AnimalSearchResultCollectionViewControllerTests: XCTestCase {

    override func setUp() {
    }

    override func tearDown() {
    }

    func testShouldReturnTheCorrectNumberOfSectionsAndItems() {
        guard let animalSearchResultCollectionViewController = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(withIdentifier: "animalSearchResultCollectionViewController")
                as? AnimalSearchResultCollectionViewController else {
            XCTFail()
            return
        }
        guard let collectionView = animalSearchResultCollectionViewController.collectionView else {
            XCTFail()
            return
        }
        XCTAssertEqual(1, animalSearchResultCollectionViewController.numberOfSections(in: collectionView))
        XCTAssertEqual(9, animalSearchResultCollectionViewController.collectionView(collectionView, numberOfItemsInSection: 0))
    }

    func testShouldAlwaysAllowItemSelection() {
        guard let animalSearchResultCollectionViewController = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(withIdentifier: "animalSearchResultCollectionViewController")
                as? AnimalSearchResultCollectionViewController else {
            XCTFail()
            return
        }

        XCTAssert(animalSearchResultCollectionViewController.collectionView(
            animalSearchResultCollectionViewController.collectionView, shouldSelectItemAt: IndexPath(row: 5, section: 0)))
    }

    func testShouldTriggerPetfinderSearchWhenAnimalSearchResultCollectionViewControllerLoads() {
        guard let animalSearchResultCollectionViewController = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(withIdentifier: "animalSearchResultCollectionViewController")
                as? AnimalSearchResultCollectionViewController else {
            XCTFail()
            return
        }

        animalSearchResultCollectionViewController.api = TestApiService()
        animalSearchResultCollectionViewController.searchParams = AnimalSearchParams("Dog", "Los Angeles")
        animalSearchResultCollectionViewController.viewDidLoad()
    }

    func testShouldDisplayAlertWhenAPICallFails() {
        guard let animalSearchResultCollectionViewController = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(withIdentifier: "animalSearchResultCollectionViewController")
                as? AnimalSearchResultCollectionViewController else {
            XCTFail()
            return
        }

        var failureCallbackWasCalled = false
        animalSearchResultCollectionViewController.failureCallback = { _ in failureCallbackWasCalled = true }

        animalSearchResultCollectionViewController.api = FailingApiService()
        animalSearchResultCollectionViewController.searchParams = AnimalSearchParams("Dog", "Los Angeles")
        animalSearchResultCollectionViewController.viewDidLoad()

        XCTAssert(failureCallbackWasCalled)
    }
}
