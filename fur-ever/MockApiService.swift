import Foundation

// Mock API service for testing purposes
class MockApiService: Api {
    func api(host: String) {
        // No-op in our initial mock version.
    }

    func searchAnimals(with params: AnimalSearchParams,
                then: ((AnimalSearchResult) -> Void)?,
                fail: ((Error) -> Void)?) {
        if let callback = then {
            callback(AnimalSearchResult(animals: [
                AnimalBasicInfo(id: 0001, photos: [Photo(full: "https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/46382994/2/?bust=1572030625&width=1080")], name: "Pecan")
            ]))
        }
    }

    func getAnimal(with animalId: Int,
                then: ((AnimalResultInfo) -> Void)?,
                fail: ((Error) -> Void)?) {
        if let callback = then {
            callback(AnimalResultInfo(animal: Animal(id: 0002, name: "Diamond", photos: [Photo(full: "https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/44425877/1/?bust=1554850023&width=1080")], type: "Dog", age: "Baby", gender: "Female", size: "Small", description: placeholderText, breeds: Breed(primary: "Dachshund", secondary: "Chihuahua"), attributes: Attributes(spayed_neutered: true, house_trained: true), contact: Contact(email: "fake2@gmail.com", phone: "123-456-7890", address: Address(city: "Pasadena", state: "CA"))))
            )
        }
    }

    func searchOrganizations(with params: OrganizationSearchParams,
                then: ((OrganizationSearchResult) -> Void)?,
                fail: ((Error) -> Void)?) {
        if let callback = then {
            callback(OrganizationSearchResult(organizations: [
                Organization(id: "0001", name: "Pacific Pups Rescue", email: "pacificpupsrescue@gmail.com", phone: "012-345-6789", website: "http://pacificpupsrescue.org", address: Address(city: "Sacramento", state: "CA"), photos: [Photo(full: "https://s3.amazonaws.com/petfinder-us-east-1-petimages-prod/organization-photos/46947/46947-1.jpg?bust=2017-11-29+07%3A54%3A33")], mission_statement: placeholderText)
            ]))
        }
    }

    let placeholderText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
}
