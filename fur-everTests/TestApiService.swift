import XCTest
@testable import FurEver

// For tests, we don't call the callback because we just want to make sure the right parameters were sent.
class TestApiService: Api {
    func api(host: String) {}
    func searchAnimals(with params: AnimalSearchParams,
            then: ((AnimalSearchResult) -> Void)?,
            fail: ((Error) -> Void)?) {
        XCTAssertEqual(params.animalType, "Dog")
        XCTAssertEqual(params.location, "Los Angeles")
    }
    func getAnimal(with animalId: Int,
                       then: ((Animal) -> Void)?,
                       fail: ((Error) -> Void)?) {
        XCTAssertEqual(animalId, 12345)
    }
    func searchOrganizations(with params: OrganizationSearchParams,
            then: ((OrganizationSearchResult) -> Void)?,
            fail: ((Error) -> Void)?) {
        XCTAssertEqual(params.name, "Petspace")
        XCTAssertEqual(params.location, "Anaheim")
    }
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
                       fail: ((Error) -> Void)?) {
        if let callback = fail {
           callback(NSError(domain: "test", code: 0, userInfo: nil))
        }
    }
    func searchOrganizations(with params: OrganizationSearchParams,
            then: ((OrganizationSearchResult) -> Void)?,
            fail: ((Error) -> Void)?) {
        if let callback = fail {
           callback(NSError(domain: "test", code: 0, userInfo: nil))
        }
    }
}
