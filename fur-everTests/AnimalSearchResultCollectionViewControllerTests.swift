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
        animalSearchResultCollectionViewController.searchParams = AnimalSearchParams(animal_type: "Dog", location: "Los Angeles", organizationId: "0123")
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
        animalSearchResultCollectionViewController.searchParams = AnimalSearchParams(animal_type: "Dog", location: "Los Angeles", organizationId: "0123")
        animalSearchResultCollectionViewController.viewDidLoad()

        XCTAssert(failureCallbackWasCalled)
    }
}

class TestApiService: Api {
    func api(host: String) {}
    func searchAnimals(with params: AnimalSearchParams,
            then: ((AnimalSearchResult) -> Void)?,
            fail: ((Error) -> Void)?) {
        // For this test, we don't call the callback because we just want to make sure the right parameters were sent.
        XCTAssertEqual(params.animal_type, "Dog")
        XCTAssertEqual(params.location, "Los Angeles")
        XCTAssertEqual(params.organizationId, "0123")
    }
    func getAnimal(with id: Int,
                       then: ((Animal) -> Void)?,
                       fail: ((Error) -> Void)?) {}
    func searchOrganizations(with params: OrganizationSearchParams,
            then: ((OrganizationSearchResult) -> Void)?,
            fail: ((Error) -> Void)?) {}
    func getOrganization(with id: String,
                       then: ((Organization) -> Void)?,
                       fail: ((Error) -> Void)?) {}
}

class FailingApiService: Api {
    func api(host: String) {}
    func searchAnimals(with params: AnimalSearchParams,
            then: ((AnimalSearchResult) -> Void)?,
            fail: ((Error) -> Void)?) {
        // For this test, we call the fail function unconditionally because we want to test the error.
        if let callback = fail {
           callback(NSError(domain: "test", code: 0, userInfo: nil))
        }
    }
    func getAnimal(with id: Int,
                       then: ((Animal) -> Void)?,
                       fail: ((Error) -> Void)?) {}
    func searchOrganizations(with params: OrganizationSearchParams,
            then: ((OrganizationSearchResult) -> Void)?,
            fail: ((Error) -> Void)?) {}
    func getOrganization(with id: String,
                       then: ((Organization) -> Void)?,
                       fail: ((Error) -> Void)?) {}
}
