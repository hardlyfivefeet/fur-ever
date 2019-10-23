import Foundation

protocol Api {
    func api(host: String)
    func searchAnimals(with params: AnimalSearchParams,
            then: ((AnimalSearchResult) -> Void)?,
            fail: ((Error) -> Void)?)
    func searchOrganizations(with params: OrganizationSearchParams,
            then: ((OrganizationSearchResult) -> Void)?,
            fail: ((Error) -> Void)?)
}

class ApiService: Api {
    func api(host: String) {
        // No-op in our initial mock version.
    }
    
    let animalResult1 = Animal(id: 0001, name: "Hopper", type: "Dog", breeds: Breed(primary: "Dachshund"), age: "Young", gender: "Male", size: "Small", description: "A good boi", organization_id: "Org0001", image: Image(url: "https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/46278443/1/?bust=1571149006&width=1080"))
    let animalResult2 = Animal(id: 0002, name: "Gracie", type: "Dog", breeds: Breed(primary: "Dachshund"), age: "Young", gender: "Female", size: "Small", description: "A good gal", organization_id: "Org0002", image: Image(url: "https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/46278443/3/?bust=1571149034&width=1080"))
    let animalResult3 = Animal(id: 0003, name: "Arlo", type: "Dog", breeds: Breed(primary: "Dachshund"), age: "Baby", gender: "Male", size: "Small", description: "LOOK AT HIM", organization_id: "Org0003", image: Image(url: "https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/46296039/2/?bust=1571268294&width=1080"))

    let organizationResult1 = Organization(id: "0001", name: "PetSpace", email: "petspace@gmail.com", phone: "0123456789", address: ["StreetA", "TownB"])
    
    func searchAnimals(with params: AnimalSearchParams,
                       then: ((AnimalSearchResult) -> Void)?,
                       fail: ((Error) -> Void)?) {
        if let callback = then {
            callback(AnimalSearchResult(animals: [animalResult1, animalResult2, animalResult3, animalResult1, animalResult3]))
        }
    }
    
    func searchOrganizations(with params: OrganizationSearchParams,
                       then: ((OrganizationSearchResult) -> Void)?,
                       fail: ((Error) -> Void)?) {
        if let callback = then {
               callback(OrganizationSearchResult(organizations: [organizationResult1, organizationResult1]))
        }
    }
}
