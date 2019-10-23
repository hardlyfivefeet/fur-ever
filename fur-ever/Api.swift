import Foundation

protocol Api {
    func api(host: String)
    func searchGifs(with params: SearchParams,
            then: ((SearchResult) -> Void)?,
            fail: ((Error) -> Void)?) // catch is a reserved word so we can't use that.
    func searchAnimals(with params: AnimalSearchParams,
            then: ((AnimalSearchResult) -> Void)?,
            fail: ((Error) -> Void)?)
}

class ApiService: Api {
    func api(host: String) {
        // No-op in our initial mock version.
    }
    
    let animalResult1 = Animal(id: 0001, name: "Hopper", type: "Dog", breeds: Breed(primary: "Dachshund"), age: "Young", gender: "Male", size: "Small", description: "A good boi", organization_id: "Org0001", image: Image(url: "https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/46278443/1/?bust=1571149006&width=1080"))
    let animalResult2 = Animal(id: 0002, name: "Gracie", type: "Dog", breeds: Breed(primary: "Dachshund"), age: "Young", gender: "Female", size: "Small", description: "A good gal", organization_id: "Org0002", image: Image(url: "https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/46278443/3/?bust=1571149034&width=1080"))
    let animalResult3 = Animal(id: 0003, name: "Arlo", type: "Dog", breeds: Breed(primary: "Dachshund"), age: "Baby", gender: "Male", size: "Small", description: "LOOK AT HIM", organization_id: "Org0003", image: Image(url: "https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/46296039/2/?bust=1571268294&width=1080"))

    
    func searchAnimals(with params: AnimalSearchParams,
                       then: ((AnimalSearchResult) -> Void)?,
                       fail: ((Error) -> Void)?) {
        if let callback = then {
            callback(AnimalSearchResult(animals: [animalResult1, animalResult2, animalResult3, animalResult1, animalResult3]))
        }
    }
    

    func searchGifs(with params: SearchParams,
            then: ((SearchResult) -> Void)?,
            fail: ((Error) -> Void)?) {
        if let callback = then {
            callback(SearchResult(data: [
                Gif(id: "26BRBupa6nRXMGBP2", source_tld: "", images: Images(
                    fixed_width: FixedWidth(url: "https://media2.giphy.com/media/26BRBupa6nRXMGBP2/200w.gif?cid=e1bb72ff5ba9df1d5249616f457f56c5")
                )),

                Gif(id: "hklv9aNS7Gcda", source_tld: "", images: Images(
                    fixed_width: FixedWidth(url: "https://media2.giphy.com/media/hklv9aNS7Gcda/200w.gif?cid=e1bb72ff5ba9df1d5249616f457f56c5")
                )),

                Gif(id: "YJBNjrvG5Ctmo", source_tld: "", images: Images(
                    fixed_width: FixedWidth(url: "https://media0.giphy.com/media/YJBNjrvG5Ctmo/200w.gif?cid=e1bb72ff5ba9df1d5249616f457f56c5")
                ))
            ]))
        }
    }
}
