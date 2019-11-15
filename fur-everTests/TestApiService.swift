import XCTest
@testable import FurEver

// For these tests, we don't call the callback because we just want to make sure the right parameters were sent.
class TestApiService: Api {
    func api(host: String) {}
    func getToken(with params: TokenRequestParams,
                  fail: ((Error) -> Void)?) {}
    func tokenHasExpired() -> Bool { return false }
    func searchAnimals(with params: AnimalSearchParams,
            then: ((AnimalSearchResult) -> Void)?,
            fail: ((Error) -> Void)?) {
        XCTAssertEqual(params.animalType, "Dog")
        XCTAssertEqual(params.location, "Los Angeles")
    }
    func getAnimal(with animalId: Int,
                       then: ((AnimalResultInfo) -> Void)?,
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

class TestNilApiService: Api {
    func api(host: String) {}
    func getToken(with params: TokenRequestParams,
                  fail: ((Error) -> Void)?) {}
    func tokenHasExpired() -> Bool { return false }
    func searchAnimals(with params: AnimalSearchParams,
            then: ((AnimalSearchResult) -> Void)?,
            fail: ((Error) -> Void)?) {}
    func getAnimal(with animalId: Int,
                       then: ((AnimalResultInfo) -> Void)?,
                       fail: ((Error) -> Void)?) {
        if let callback = then {
            callback(AnimalResultInfo(animal: Animal(id: 0001, name: "Test", photos: [], breeds: Breed(), attributes: Attributes(), environment: Environment(), contact: Contact(address: Address())))
            )
        }
    }
    func searchOrganizations(with params: OrganizationSearchParams,
            then: ((OrganizationSearchResult) -> Void)?,
            fail: ((Error) -> Void)?) {}
}

// For these tests, we call the fail function unconditionally because we want to test the error.
class FailingApiService: Api {
    func api(host: String) {}
    func getToken(with params: TokenRequestParams,
                  fail: ((Error) -> Void)?) {}
    func tokenHasExpired() -> Bool { return false }
    func searchAnimals(with params: AnimalSearchParams,
            then: ((AnimalSearchResult) -> Void)?,
            fail: ((Error) -> Void)?) {
        if let callback = fail {
           callback(NSError(domain: "test", code: 0, userInfo: nil))
        }
    }
    func getAnimal(with id: Int,
                       then: ((AnimalResultInfo) -> Void)?,
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
