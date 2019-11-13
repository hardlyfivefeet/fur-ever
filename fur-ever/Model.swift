import UIKit

let TESTING_UI = "UI_TESTING"

struct Token: Codable {
    let token_type: String
    let expires_in: Int
    let access_token: String
}

struct TokenRequestParams {
    let grant_type = "client_credentials"
    let client_id = "pooaBebLG91ar31WgMgmN6UXl4LXsvFbCRIwxc3VQK9A8e27Sr"
    let client_secret = "pHwGbvEDZDVybz58WAMwKKcbFrPtqEF72V7SeRO4"
}

protocol Copyable: class {
    init(copy: Self)
}

class AnimalSearchParams: Copyable {
    var animalType: String?
    var location: String?
    var organizationId: String?
    var breeds: Filter?
    var age = Filter(["Baby", "Young", "Adult", "Senior"])
    var size = Filter(["Small", "Medium", "Large", "XLarge"])
    var gender = Filter(["Male", "Female"])
    var distance: Int = 100

    init(_ animalType: String, _ location: String) {
        self.animalType = animalType
        self.location = location
    }

    init(organizationId: String) {
        self.organizationId = organizationId
        self.location = ""
    }

    required init(copy: AnimalSearchParams) {
        self.animalType = copy.animalType
        self.location = copy.location
        self.breeds = Filter(copy: copy.breeds!)
        self.age = Filter(copy: copy.age)
        self.size = Filter(copy: copy.size)
        self.gender = Filter(copy: copy.gender)
        self.distance = copy.distance
    }
}

struct AnimalSearchResult: Codable, Equatable {
    let animals: [AnimalBasicInfo]
}

struct AnimalBasicInfo: Codable, Equatable {
    let id: Int
    let photos: [Photo]
    let name: String
    var distance: Double?
}

struct AnimalResultInfo: Codable, Equatable {
    let animal: Animal
}

struct Animal: Codable, Equatable {
    let id: Int
    let name: String
    let photos: [Photo]
    var age: String?
    var gender: String?
    var size: String?
    var coat: String?
    var url: String?
    let breeds: Breed
    let attributes: Attributes
    let environment: Environment
    let contact: Contact
}

struct Environment: Codable, Equatable {
    var children: Bool?
    var dogs: Bool?
    var cats: Bool?
}

struct Attributes: Codable, Equatable {
    var spayed_neutered: Bool?
    var house_trained: Bool?
    var declawed: Bool?
    var special_needs: Bool?
    var shots_current: Bool?
}

struct Address: Codable, Equatable {
    var address1: String?
    var city: String?
    var state: String?
}

struct Contact: Codable, Equatable {
    var email: String?
    var phone: String?
    var address: Address
}

struct Breed: Codable, Equatable {
    var primary: String?
    var secondary: String?
    var mixed: Bool?
}

struct Photo: Codable, Equatable {
    var medium: String?
}

struct OrganizationSearchParams {
    var name: String?
    var location: String?
}

struct OrganizationSearchResult: Codable, Equatable {
    let organizations: [Organization]
}

struct Organization: Codable, Equatable {
    let id: String
    let name: String
    var email: String?
    var phone: String?
    var website: String?
    let address: Address
    let photos: [Photo]
    var distance: Double?
    var url: String?
}

class Filter: Copyable {
    var appliedFilters: [Int] = []
    var availableValues: [String]
    init(_ availableValues: [String]) {
        self.availableValues = availableValues
    }
    required init(copy: Filter) {
        self.appliedFilters = copy.appliedFilters
        self.availableValues = copy.availableValues
    }
}

struct Breeds {
    static let dogBreeds = ["Affenpinscher", "Afghan Hound", "Airedale Terrier", "Akita", "Alaskan Malamute", "American Bulldog", "American Eskimo Dog", "American Foxhound", "American Hairless Terrier", "American Staffordshire Terrier", "American Water Spaniel", "Anatolian Shepherd", "Australian Cattle Dog", "Australian Shepherd", "Australian Terrier", "Basenji", "Basset Hound", "Beagle", "Bearded Collie", "Beauceron", "Bedlington Terrier", "Belgian Shepherd / Malinois", "Belgian Shepherd / Sheepdog", "Belgian Shepherd / Tervuren", "Bernese Mountain Dog", "Bichon Frise", "Black and Tan Coonhound", "Black Russian Terrier", "Bloodhound", "Bluetick Coonhound", "Boerboel", "Border Collie", "Border Terrier", "Borzoi", "Boston Terrier", "Bouvier des Flandres", "Boxer", "Boykin Spaniel", "Briard", "Brittany Spaniel", "Brussels Griffon", "Bull Terrier", "Bullmastiff", "Cairn Terrier", "Canaan Dog", "Cane Corso", "Cardigan Welsh Corgi", "Carolina Dog", "Cavalier King Charles Spaniel", "Chesapeake Bay Retriever", "Chihuahua", "Chinese Crested Dog", "Chinook", "Chow Chow", "Cirneco dell'Etna", "Clumber Spaniel", "Collie", "Coton de Tulear", "Curly-Coated Retriever", "Dachshund", "Dalmatian", "Dandie Dinmont Terrier", "Doberman Pinscher", "Dogo Argentino", "Dogue de Bordeaux", "Dutch Shepherd", "English Bulldog", "English Cocker Spaniel", "English Coonhound", "English Foxhound", "English Pointer", "English Setter", "English Shepherd", "English Springer Spaniel", "English Toy Spaniel", "Entlebucher", "Field Spaniel", "Finnish Lapphund", "Finnish Spitz", "French Bulldog", "German Pinscher", "German Shepherd Dog", "German Shorthaired Pointer", "German Wirehaired Pointer", "Giant Schnauzer", "Glen of Imaal Terrier", "Golden Retriever", "Gordon Setter", "Great Dane", "Great Pyrenees", "Greater Swiss Mountain Dog", "Greyhound", "Harrier", "Havanese", "Ibizan Hound", "Icelandic Sheepdog", "Irish Setter", "Irish Terrier", "Irish Water Spaniel", "Irish Wolfhound", "Italian Greyhound", "Jack Russell Terrier", "Japanese Chin", "Jindo", "Keeshond", "Kerry Blue Terrier", "Komondor", "Kuvasz", "Labrador Retriever", "Lakeland Terrier", "Leonberger", "Lhasa Apso", "Lowchen", "Maltese", "Manchester Terrier", "Mastiff", "Miniature Bull Terrier", "Miniature Dachshund", "Miniature Pinscher", "Miniature Poodle", "Miniature Schnauzer", "Neapolitan Mastiff", "Newfoundland Dog", "Norfolk Terrier", "Norwegian Buhund", "Norwegian Elkhound", "Norwegian Lundehund", "Norwich Terrier", "Nova Scotia Duck Tolling Retriever", "Old English Sheepdog", "Otterhound", "Papillon", "Parson Russell Terrier", "Pekingese", "Pembroke Welsh Corgi", "Petit Basset Griffon Vendeen", "Pharaoh Hound", "Plott Hound", "Polish Lowland Sheepdog", "Pomeranian", "Poodle", "Portuguese Podengo", "Portuguese Water Dog", "Pug", "Puli", "Pyrenean Shepherd", "Rat Terrier", "Redbone Coonhound", "Rhodesian Ridgeback", "Saint Bernard", "Saluki", "Samoyed", "Schipperke", "Schnauzer", "Scottish Deerhound", "Scottish Terrier", "Sealyham Terrier", "Shar-Pei", "Shetland Sheepdog / Sheltie", "Shiba Inu", "Shih Tzu", "Siberian Husky", "Silky Terrier", "Skye Terrier", "Sloughi", "Smooth Fox Terrier", "Spanish Water Dog", "Spinone Italiano", "Staffordshire Bull Terrier", "Sussex Spaniel", "Swedish Vallhund", "Tibetan Mastiff", "Tibetan Spaniel", "Tibetan Terrier", "Toy Fox Terrier", "Toy Manchester Terrier", "Treeing Walker Coonhound", "Vizsla", "Weimaraner", "Welsh Springer Spaniel", "Welsh Terrier", "West Highland White Terrier / Westie", "Wheaten Terrier", "Whippet", "Wire Fox Terrier", "Wirehaired Pointing Griffon", "Xoloitzcuintli / Mexican Hairless", "Yorkshire Terrier"]
    static let catBreeds = ["Abyssinian", "American Bobtail", "American Curl", "American Shorthair", "American Wirehair", "Applehead Siamese", "Balinese", "Bengal", "Birman", "Bombay", "British Shorthair", "Burmese", "Burmilla", "Calico", "Canadian Hairless", "Chartreux", "Chausie", "Chinchilla", "Cornish Rex", "Cymric", "Devon Rex", "Dilute Calico", "Dilute Tortoiseshell", "Domestic Long Hair", "Domestic Medium Hair", "Domestic Short Hair", "Egyptian Mau", "Exotic Shorthair", "Extra-Toes Cat / Hemingway Polydactyl", "Havana", "Himalayan", "Japanese Bobtail", "Javanese", "Korat", "LaPerm", "Maine Coon", "Manx", "Munchkin", "Nebelung", "Norwegian Forest Cat", "Ocicat", "Oriental Long Hair", "Oriental Short Hair", "Oriental Tabby", "Persian", "Pixiebob", "Ragamuffin", "Ragdoll", "Russian Blue", "Scottish Fold", "Selkirk Rex", "Siamese", "Siberian", "Silver", "Singapura", "Snowshoe", "Somali", "Sphynx / Hairless Cat", "Tabby", "Tiger", "Tonkinese", "Torbie", "Tortoiseshell", "Turkish Angora", "Turkish Van", "Tuxedo", "York Chocolate"]
    static let birdBreeds = ["African Grey", "Amazon", "Brotogeris", "Budgie / Budgerigar", "Button-Quail", "Caique", "Canary", "Chicken", "Cockatiel", "Cockatoo", "Conure", "Dove", "Duck", "Eclectus", "Emu", "Finch", "Goose", "Guinea Fowl", "Kakariki", "Lory / Lorikeet", "Lovebird", "Macaw", "Ostrich", "Parakeet (Other)", "Parrot (Other)", "Parrotlet", "Peacock / Peafowl", "Pheasant", "Pigeon", "Pionus", "Poicephalus / Senegal", "Quail", "Quaker Parakeet", "Rhea", "Ringneck / Psittacula", "Rosella", "Swan", "Toucan", "Turkey"]
    static let rabbitBreeds = ["American", "American Fuzzy Lop", "American Sable", "Angora Rabbit", "Belgian Hare", "Beveren", "Britannia Petite", "Bunny Rabbit", "Californian", "Champagne D'Argent", "Checkered Giant", "Chinchilla", "Cinnamon", "Creme D'Argent", "Dutch", "Dwarf", "Dwarf Eared", "English Lop", "English Spot", "Flemish Giant", "Florida White", "French Lop", "Harlequin", "Havana", "Himalayan", "Holland Lop", "Hotot", "Jersey Wooly", "Lilac", "Lionhead", "Lop Eared", "Mini Lop", "Mini Rex", "Netherland Dwarf", "New Zealand", "Palomino", "Polish", "Rex", "Rhinelander", "Satin", "Silver", "Silver Fox", "Silver Marten", "Tan"]
}
