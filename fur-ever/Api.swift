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
    func getOrganization(with organizationId: String,
                then: ((Organization) -> Void)?,
                fail: ((Error) -> Void)?)
}

// Fake API calls that return hardcoded data
class ApiService: Api {
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
            callback(Animal(basicInfo: animalBasicInfo1, type: "Dog", breed: Breed(primary: "Dachshund", secondary: "Chihuahua", mixed: true), age: "Baby", gender: "Male", size: "Small", description: placeholderText, attributes: Attributes(spayedNeutered: true, houseTrained: true), contact: Contact(email: "fake2@gmail.com", phone: "012-345-6789", location: Location(state: "CA"))))
        }
    }

    func searchOrganizations(with params: OrganizationSearchParams,
                then: ((OrganizationSearchResult) -> Void)?,
                fail: ((Error) -> Void)?) {
        if let callback = then {
               callback(OrganizationSearchResult(organizations: [organizationBasicInfo1, organizationBasicInfo2]))
        }
    }

    func getOrganization(with organizationId: String,
                then: ((Organization) -> Void)?,
                fail: ((Error) -> Void)?) {
        if let callback = then {
            callback(Organization(basicInfo: organizationBasicInfo1, image: Image(url: "https://s3.amazonaws.com/petfinder-us-east-1-petimages-prod/organization-photos/27452/27452-1.jpg?bust=2017-07-23+19%3A42%3A27"), contact: Contact(email: "silky-rescue@gmail.com", phone: "012-345-6789", location: Location(city: "Culver City", state: "CA"), website: "http://silkyrescue.org"), missionStatement: placeholderText))
        }
    }
}

let animalBasicInfo1 = AnimalBasicInfo(id: 0001, image: Image(url: "https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/46278443/1/?bust=1571149006&width=1080"), name: "Hopper")

let animalBasicInfo2 = AnimalBasicInfo(id: 0002, image: Image(url: "https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/46278443/3/?bust=1571149034&width=1080"), name: "Gracie")

let animalBasicInfo3 = AnimalBasicInfo(id: 0003, image: Image(url: "https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/46296039/2/?bust=1571268294&width=1080"), name: "Arlo")

let organizationBasicInfo1 = OrganizationBasicInfo(id: "0001", name: "Silky Terrier Rescue Charitable Trust Charity")

let organizationBasicInfo2 = OrganizationBasicInfo(id: "0002", name: "Marley's Pit Stop Rescue")

let placeholderText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
