import Foundation

protocol Api {
    func api(host: String)
    func searchAnimals(with params: AnimalSearchParams,
                then: ((AnimalSearchResult) -> Void)?,
                fail: ((Error) -> Void)?)
    func getAnimal(with animalId: Int,
                then: ((Animal) -> Void)?,
                fail: ((Error) -> Void)?)
    func searchOrganizations(with params: OrganizationSearchParams,
                then: ((OrganizationSearchResult) -> Void)?,
                fail: ((Error) -> Void)?)
}

// Placeholder API that returns hardcoded data
class PlaceholderApiService: Api {
    func api(host: String) {
        // No-op in our initial mock version.
    }

    func searchAnimals(with params: AnimalSearchParams,
                then: ((AnimalSearchResult) -> Void)?,
                fail: ((Error) -> Void)?) {
        if let callback = then {
            callback(AnimalSearchResult(animals: [animalBasicInfo1, animalBasicInfo2, animalBasicInfo3, animalBasicInfo1, animalBasicInfo3, animalBasicInfo1, animalBasicInfo2, animalBasicInfo1, animalBasicInfo3]))
        }
    }

    func getAnimal(with animalId: Int,
                then: ((Animal) -> Void)?,
                fail: ((Error) -> Void)?) {
        if let callback = then {
            callback(Animal(id: 0001, name: "Hopper", photos: [Photo(full: "https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/46278443/1/?bust=1571149006&width=1080")], type: "Dog", age: "Baby", gender: "Male", size: "Small", description: placeholderText, breeds: Breed(primary: "Dachshund", secondary: "Chihuahua", mixed: true), attributes: Attributes(spayed_neutered: true, house_trained: true), contact: Contact(email: "fake2@gmail.com", phone: "012-345-6789", address: Address(state: "CA"))))
        }
    }

    func searchOrganizations(with params: OrganizationSearchParams,
                then: ((OrganizationSearchResult) -> Void)?,
                fail: ((Error) -> Void)?) {
        if let callback = then {
               callback(OrganizationSearchResult(organizations: [organization1, organization2]))
        }
    }
}

let animalBasicInfo1 = AnimalBasicInfo(id: 0001, photos: [Photo(full: "https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/46278443/1/?bust=1571149006&width=1080")], name: "Hopper")

let animalBasicInfo2 = AnimalBasicInfo(id: 0002, photos: [Photo(full: "https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/46278443/3/?bust=1571149034&width=1080")], name: "Gracie")

let animalBasicInfo3 = AnimalBasicInfo(id: 0003, photos: [Photo(full: "https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/46296039/2/?bust=1571268294&width=1080")], name: "Arlo")

let organization1 = Organization(id: "CA0001", name: "Silky Terrier Rescue Charitable Trust Charity", email: "silky-rescue@gmail.com", phone: "012-345-6789", website: "http://silkyrescue.org", address: Address(city: "Culver City", state: "CA"), photos: [Photo(full: "https://s3.amazonaws.com/petfinder-us-east-1-petimages-prod/organization-photos/27452/27452-1.jpg?bust=2017-07-23+19%3A42%3A27")], mission_statement: placeholderText)

let organization2 = Organization(id: "CA0002", name: "Marley's Pit Stop Rescue", address: Address(city: nil), photos: [Photo(full: nil)])

let placeholderText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
