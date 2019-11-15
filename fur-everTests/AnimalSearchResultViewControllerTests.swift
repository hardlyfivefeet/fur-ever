import XCTest
@testable import FurEver

class AnimalSearchResultViewControllerTests: XCTestCase {

    var viewControllerUnderTest: AnimalSearchResultViewController!

    override func setUp() {
        super.setUp()

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.viewControllerUnderTest = storyboard.instantiateViewController(withIdentifier: "animalSearchResultViewController") as? AnimalSearchResultViewController
    }

    func testShouldTriggerPetfinderSearchWhenAnimalSearchResultViewControllerLoads() {
        viewControllerUnderTest.api = TestApiService()
        viewControllerUnderTest.animalId = 12345
        viewControllerUnderTest.viewDidLoad()
    }

    func testShouldDisplayAlertWhenAPICallFails() {
        var failureCallbackWasCalled = false
        viewControllerUnderTest.failureCallback = { _ in failureCallbackWasCalled = true }

        viewControllerUnderTest.api = FailingApiService()
        viewControllerUnderTest.animalId = 12345
        viewControllerUnderTest.viewDidLoad()

        XCTAssert(failureCallbackWasCalled)
    }

    func testShouldDisplayCorrectEmptyInfoWhenFieldsInAnimalResultAreNil() {
        viewControllerUnderTest.api = TestNilApiService()
        viewControllerUnderTest.animalId = 12345
        guard let _ = viewControllerUnderTest.view else {
            XCTFail()
            return
        }

        XCTAssertEqual(viewControllerUnderTest.name.text, "Test")
        XCTAssertEqual(viewControllerUnderTest.image.image, UIImage(named: "NoImageAvailable"))
        XCTAssertEqual(viewControllerUnderTest.breed.text, "Breed: Unknown")
        XCTAssertEqual(viewControllerUnderTest.age.text, "Age: Not Available")
        XCTAssertEqual(viewControllerUnderTest.gender.text, "Gender: Not Available")
        XCTAssertEqual(viewControllerUnderTest.size.text, "Size: Not Available")
        XCTAssertEqual(viewControllerUnderTest.attributes.text, "Not house-trained\nNot spayed/neutered")
        XCTAssertNotNil(viewControllerUnderTest.contact!.text)
    }

    func testShouldDisplayCorrectAnimalWhenAnimalSearchResultViewControllerLoads() {
        viewControllerUnderTest.api = MockApiService()
        viewControllerUnderTest.searchDistance = 1.00
        viewControllerUnderTest.animalId = 0001
        guard let _ = viewControllerUnderTest.view else {
            XCTFail()
            return
        }

        XCTAssertEqual(viewControllerUnderTest.name.text, "Diamond")
        XCTAssertEqual(viewControllerUnderTest.image.imageURL, "https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/44425877/1/?bust=1554850023&width=1080")
        XCTAssertEqual(viewControllerUnderTest.breed.text, "Breed: Dachshund, Chihuahua Mix")
        XCTAssertEqual(viewControllerUnderTest.age.text, "Age: Baby")
        XCTAssertEqual(viewControllerUnderTest.gender.text, "Gender: Female")
        XCTAssertEqual(viewControllerUnderTest.size.text, "Size: Small")
        XCTAssertEqual(viewControllerUnderTest.attributes.text, "House-trained\nSpayed/Neutered")
        XCTAssertNotNil(viewControllerUnderTest.contact!.text)
    }
}
