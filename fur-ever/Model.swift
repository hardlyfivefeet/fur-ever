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
    let animals: String
}

enum Rating: String {
    case Y = "y"
    case G = "g"
    case PG = "pg"
    case PG13 = "pg-13"
    case R = "r"
}

// For now, this is just a subset of what's available:
//     https://developers.giphy.com/docs/#operation--gifs-search-get
struct SearchParams {
    let rating: Rating
    let query: String
}

// Similarly, this is a subset of everything that comes back.
struct SearchResult: Codable, Equatable {
    let data: [Gif]
}

// You know the drill: another subset.
//     https://developers.giphy.com/docs/#gif-object
struct Gif: Codable, Equatable {
    let id: String
    let source_tld: String
    let images: Images
}

// https://developers.giphy.com/docs/#images-object
struct Images: Codable, Equatable {
    let fixed_width: FixedWidth
}

struct FixedWidth: Codable, Equatable {
    let url: String
}
