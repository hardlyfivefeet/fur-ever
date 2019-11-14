import XCTest
@testable import FurEver

class AnimalSearchResultViewControllerTests: XCTestCase {

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

    func testShouldDisplayCorrectAnimalWhenAnimalSearchResultViewControllerLoads() {
        guard let animalSearchResultViewController = UIStoryboard(name: "Main", bundle: nil)
                       .instantiateViewController(withIdentifier: "animalSearchResultViewController")
                       as? AnimalSearchResultViewController else {
           XCTFail()
           return
        }

        animalSearchResultViewController.api = PlaceholderApiService()
        animalSearchResultViewController.animalId = 0001

        guard let _ = animalSearchResultViewController.view else {
            XCTFail()
            return
        }

        XCTAssertEqual(animalSearchResultViewController.name.text, "Hopper")
        XCTAssertEqual(animalSearchResultViewController.image.imageURL, "https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/46278443/1/?bust=1571149006&width=1080")
        XCTAssertEqual(animalSearchResultViewController.breed.text, "Breed: Dachshund, Chihuahua Mix")
        XCTAssertEqual(animalSearchResultViewController.age.text, "Age: Baby")
        XCTAssertEqual(animalSearchResultViewController.gender.text, "Gender: Male")
        XCTAssertEqual(animalSearchResultViewController.size.text, "Size: Small")
        XCTAssertNotNil(animalSearchResultViewController.attributes!.text)
        XCTAssertNotNil(animalSearchResultViewController.contact!.text)
    }
}
