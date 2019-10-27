import Foundation

class MockApiService: Api {
    func api(host: String) {
        // No-op in our initial mock version.
    }

    func searchAnimals(with params: AnimalSearchParams,
            then: ((AnimalSearchResult) -> Void)?,
            fail: ((Error) -> Void)?) {
        if let callback = then {
            callback(AnimalSearchResult(animals: [
                AnimalBasicInfo(id: 0001, image: Image(url: "https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/46382994/2/?bust=1572030625&width=1080"), name: "Pecan")
            ]))
        }
    }

    func getAnimal(with id: Int,
                          then: ((Animal) -> Void)?,
                          fail: ((Error) -> Void)?) {
        if let callback = then {
            callback(Animal(basicInfo: AnimalBasicInfo(id: 0001, image: Image(url: "https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/44425877/1/?bust=1554850023&width=1080"), name: "Diamond"), type: "Dog", breed: Breed(primary: "Dachshund", secondary: "Chihuahua"), age: "Baby", gender: "Female", size: "Small", description: "A good gal", attributes: Attributes(spayed_neutered: true, house_trained: true), contact: Contact(email: "fake2@gmail.com", phone: "123-456-7890", location: Location(city: "Pasadena", state: "CA")))
            )
        }
    }

    func searchOrganizations(with params: OrganizationSearchParams,
            then: ((OrganizationSearchResult) -> Void)?,
            fail: ((Error) -> Void)?) {
        if let callback = then {
            callback(OrganizationSearchResult(organizations: [
                OrganizationBasicInfo(id: 0001, name: "Annenberg Pet Space LA")
            ]))
        }
    }

    func getOrganization(with id: Int,
                         then: ((Organization) -> Void)?,
                         fail: ((Error) -> Void)?) {
        if let callback = then {
            callback(Organization(basicInfo: OrganizationBasicInfo(id: 0001, name: "Pacific Pups Rescue"), image: Image(url: "https://s3.amazonaws.com/petfinder-us-east-1-petimages-prod/organization-photos/46947/46947-1.jpg?bust=2017-11-29+07%3A54%3A33"), contact: Contact(email: "pacificpupsrescue@gmail.com", phone: "012-345-6789", location: Location(city: "Sacramento", state: "CA"), website: "http://pacificpupsrescue.org"), missionStatement: "We protacc good bois")
            )
        }
    }

}
