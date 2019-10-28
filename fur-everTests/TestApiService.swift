import XCTest
@testable import FurEver

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
            fail: ((Error) -> Void)?) {
        XCTAssertEqual(params.name, "Petspace")
        XCTAssertEqual(params.location, "Anaheim")
    }
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
                       fail: ((Error) -> Void)?) {
        // For this test, we call the fail function unconditionally because we want to test the error.
        if let callback = fail {
           callback(NSError(domain: "test", code: 0, userInfo: nil))
        }
    }
    func searchOrganizations(with params: OrganizationSearchParams,
            then: ((OrganizationSearchResult) -> Void)?,
            fail: ((Error) -> Void)?) {
        // For this test, we call the fail function unconditionally because we want to test the error.
        if let callback = fail {
           callback(NSError(domain: "test", code: 0, userInfo: nil))
        }
    }
    func getOrganization(with id: String,
                       then: ((Organization) -> Void)?,
                       fail: ((Error) -> Void)?) {
        // For this test, we call the fail function unconditionally because we want to test the error.
        if let callback = fail {
           callback(NSError(domain: "test", code: 0, userInfo: nil))
        }
    }
}
