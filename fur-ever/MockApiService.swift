import Foundation

class MockApiService: Api {
    func api(host: String) {
        // No-op in our initial mock version.
    }
    
    func searchAnimals(with params: AnimalSearchParams,
            then: ((AnimalSearchResult) -> Void)?,
            fail: ((Error) -> Void)?) {
        // TODO: Hardcode fake data
    }
    
    func searchOrganizations(with params: OrganizationSearchParams,
            then: ((OrganizationSearchResult) -> Void)?,
            fail: ((Error) -> Void)?) {
        // TODO: Hardcode fake data
    }
}
