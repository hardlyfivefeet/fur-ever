import UIKit

let TESTING_UI = "UI_TESTING"

struct AnimalSearchParams {
    let animal_type: String
    let location: String
}

struct AnimalSearchResult: Codable, Equatable {
    let animals: [Animal]
}

struct Animal: Codable, Equatable {
    let image: Image
    let name: String
    let type: String
    let breed: Breed
    let age: String
    let gender: String
    let size: String
    let description: String
    let attributes: Attributes
    let contact: Contact
}

struct Attributes: Codable, Equatable {
    let spayed_neutered: Bool
    let house_trained: Bool
}

struct Location: Codable, Equatable {
    var street: String?
    var city: String?
    var state: String?
}

struct Contact: Codable, Equatable {
    var email: String?
    var phone: String?
    var location: Location
}

struct Breed: Codable, Equatable {
    var primary: String?
    var secondary: String?
    var mixed: Bool?
}

struct Image: Codable, Equatable {
    let url: String
}

struct OrganizationSearchParams {
    let name: String
    let location: String
}

struct OrganizationSearchResult: Codable, Equatable {
    let organizations: [Organization]
}

struct Organization: Codable, Equatable {
    let id: String
    let name: String
    let contact: Contact
}
