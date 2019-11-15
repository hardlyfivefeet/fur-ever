import Foundation

// Mock API service for tests
class MockApiService: Api {
    func api(host: String) {
        // No-op in the mock version.
    }

    func getToken(with params: TokenRequestParams,
    fail: ((Error) -> Void)?) {
        // No-op in the mock version.
    }

    func tokenHasExpired() -> Bool {
        // No-op in the mock version.
        return false
    }

    func searchAnimals(with params: AnimalSearchParams,
                then: ((AnimalSearchResult) -> Void)?,
                fail: ((Error) -> Void)?) {
        if let callback = then {
            callback(AnimalSearchResult(animals: [
                AnimalBasicInfo(id: 0001, photos: [Photo(medium: "https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/46382994/2/?bust=1572030625&width=1080")], name: "Pecan")
            ]))
        }
    }

    func getAnimal(with animalId: Int,
                then: ((AnimalResultInfo) -> Void)?,
                fail: ((Error) -> Void)?) {
        if let callback = then {
            callback(AnimalResultInfo(animal: Animal(id: 0002, name: "Diamond", photos: [Photo(medium: "https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/44425877/1/?bust=1554850023&width=1080")], age: "Baby", gender: "Female", size: "Small", breeds: Breed(primary: "Dachshund", secondary: "Chihuahua", mixed: true), attributes: Attributes(spayed_neutered: true, house_trained: true), environment: Environment(children: true, dogs: true, cats: false), contact: Contact(email: "fake2@gmail.com", phone: "123-456-7890", address: Address(city: "Pasadena", state: "CA"))))
            )
        }
    }

    func searchOrganizations(with params: OrganizationSearchParams,
                then: ((OrganizationSearchResult) -> Void)?,
                fail: ((Error) -> Void)?) {
        if let callback = then {
            callback(OrganizationSearchResult(organizations: [
                Organization(id: "0001", name: "Pacific Pups Rescue", email: "pacificpupsrescue@gmail.com", phone: "012-345-6789", website: "http://pacificpupsrescue.org", address: Address(city: "Sacramento", state: "CA"), photos: [Photo(medium: "https://s3.amazonaws.com/petfinder-us-east-1-petimages-prod/organization-photos/46947/46947-1.jpg?bust=2017-11-29+07%3A54%3A33")]), Organization(id: "0002", name: "Silky Terrier Rescue Charitable Trust", address: Address(), photos: [], url: "https://www.petfinder.com/member/us/ca/los-angeles/silky-terrier-rescue-charitable-trust-ca172/?referrer_id=633652ae-f281-4379-9011-32a03ca842e6")
            ]))
        }
    }
}
