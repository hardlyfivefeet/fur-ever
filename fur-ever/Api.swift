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
               callback(OrganizationSearchResult(organizations: [organizationResult1, organizationResult2]))
        }
    }
}

let animalResult1 = Animal(image: Image(url: "https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/46278443/1/?bust=1571149006&width=1080"), name: "Hopper", type: "Dog", breed: Breed(primary: "Dachshund"), age: "Young", gender: "Male", size: "Small", description: "A good boi", attributes: Attributes(spayed_neutered: true, house_trained: true), contact: Contact(email: "fake@gmail.com", phone: "012-3456-789", location: Location(street: "12345 Sunn Avenue MSB-6076", city: "Santa Ana,", state: "CA")))
let animalResult2 = Animal(image: Image(url: "https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/46278443/3/?bust=1571149034&width=1080"), name: "Gracie", type: "Dog", breed: Breed(primary: "Dachshund"), age: "Young", gender: "Female", size: "Small", description: "A good gal", attributes: Attributes(spayed_neutered: true, house_trained: false), contact: Contact(email: "fake1@gmail.com", phone: "012-3456-789", location: Location(city: "Fountain Valley,", state: "CA")))
let animalResult3 = Animal(image: Image(url: "https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/46296039/2/?bust=1571268294&width=1080"), name: "Arlo", type: "Dog", breed: Breed(primary: "Dachshund", secondary: "Chihuahua"), age: "Baby", gender: "Male", size: "Small", description: placeholderText, attributes: Attributes(spayed_neutered: true, house_trained: true), contact: Contact(email: "fake2@gmail.com", phone: "424-312-9265", location: Location(state: "CA")))

let organizationResult1 = Organization(id: "0001", image: Image(url: "https://s3.amazonaws.com/petfinder-us-east-1-petimages-prod/organization-photos/27452/27452-1.jpg?bust=2017-07-23+19%3A42%3A27"), name: "Silky Terrier Rescue Charitable Trust Charity", contact: Contact(email: "silky-rescue@gmail.com", phone: "012-345-6789", location: Location(city: "Culver City", state: "CA"), website: "http://silkyrescue.org"), missionStatement: placeholderText)

let organizationResult2 = Organization(id: "0002", image: Image(url: "https://s3.amazonaws.com/petfinder-us-east-1-petimages-prod/organization-photos/27910/27910-1.jpg?bust=2017-11-29+07%3A57%3A56"), name: "Marley's Pit Stop Rescue", contact: Contact(email: "pitstop@gmail.com", phone: "012-345-6789", location: Location(street: "12345 Sunn Avenue MSB-6076", city: "Santa Ana,", state: "CA")), missionStatement: "We have good bois too")

let placeholderText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
