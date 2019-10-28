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
    
    func testShouldDisplayCorrectAnimalWhenAnimalSearchResultViewControllerLoads() {
        guard let animalSearchResultViewController = UIStoryboard(name: "Main", bundle: nil)
                       .instantiateViewController(withIdentifier: "animalSearchResultViewController")
                       as? AnimalSearchResultViewController else {
           XCTFail()
           return
        }

        animalSearchResultViewController.animalId = 0001

        guard let _ = animalSearchResultViewController.view else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(animalSearchResultViewController.name.text, "Hopper")
        XCTAssertEqual(animalSearchResultViewController.image.imageURL, "https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/46278443/1/?bust=1571149006&width=1080")
        XCTAssertEqual(animalSearchResultViewController.type.text, "Dog")
        XCTAssertEqual(animalSearchResultViewController.breed.text, "Dachshund, Chihuahua Mix")
        XCTAssertEqual(animalSearchResultViewController.age.text, "Baby")
        XCTAssertEqual(animalSearchResultViewController.gender.text, "Male")
        XCTAssertEqual(animalSearchResultViewController.size.text, "Small")
        XCTAssertEqual(animalSearchResultViewController.info.text, "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
        XCTAssertNotNil(animalSearchResultViewController.attributes!.text)
        XCTAssertNotNil(animalSearchResultViewController.contact!.text)
    }
}
