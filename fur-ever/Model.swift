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
    let id: Int64
    let name: String
    let type: String
    let breeds: Breed
    let age: String
    let gender: String
    let size: String
    let description: String
    let organization_id: String
    let image: Image
}

struct Breed: Codable, Equatable {
    let primary: String
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
    let email: String
    let phone: String
    let address: [String]
}
