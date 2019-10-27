import UIKit

let TESTING_UI = "UI_TESTING"

struct AnimalSearchParams {
    var animal_type: String?
    var location: String?
    var organizationId: String?
}

struct AnimalSearchResult: Codable, Equatable {
    let animals: [AnimalBasicInfo]
}

struct AnimalBasicInfo: Codable, Equatable {
    let id: Int
    let image: Image
    let name: String
}

struct Animal: Codable, Equatable {
    let basicInfo: AnimalBasicInfo
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
    var distance: String?
}

struct Contact: Codable, Equatable {
    var email: String?
    var phone: String?
    var location: Location
    var website: String?
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
    let organizations: [OrganizationBasicInfo]
}

struct OrganizationBasicInfo: Codable, Equatable {
    let id: String
    let name: String
}

struct Organization: Codable, Equatable {
    let basicInfo: OrganizationBasicInfo
    let image: Image
    let contact: Contact
    let missionStatement: String
    var distance: Double?
}
