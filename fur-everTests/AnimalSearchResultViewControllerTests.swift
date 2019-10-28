import XCTest
@testable import FurEver

class AnimalSearchResultViewControllerTests: XCTestCase {

    override func setUp() {
    }

    override func tearDown() {
    }

    func testShouldTriggerPetfinderSearchWhenAnimalSearchResultViewControllerLoads() {
        guard let animalSearchResultViewController = UIStoryboard(name: "Main", bundle: nil)
                       .instantiateViewController(withIdentifier: "animalSearchResultViewController")
                       as? AnimalSearchResultViewController else {
           XCTFail()
           return
        }

        animalSearchResultViewController.api = TestApiService()
        animalSearchResultViewController.animalId = 12345
        animalSearchResultViewController.viewDidLoad()
    }

    func testShouldDisplayAlertWhenAPICallFails() {
        guard let animalSearchResultViewController = UIStoryboard(name: "Main", bundle: nil)
                       .instantiateViewController(withIdentifier: "animalSearchResultViewController")
                       as? AnimalSearchResultViewController else {
           XCTFail()
           return
        }

        var failureCallbackWasCalled = false
        animalSearchResultViewController.failureCallback = { _ in failureCallbackWasCalled = true }

        animalSearchResultViewController.api = FailingApiService()
        animalSearchResultViewController.animalId = 12345
        animalSearchResultViewController.viewDidLoad()

        XCTAssert(failureCallbackWasCalled)
    }
}
