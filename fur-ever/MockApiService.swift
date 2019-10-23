import Foundation

class MockApiService: Api {
    func api(host: String) {
        // No-op in our initial mock version.
    }
    
    func searchAnimals(with params: AnimalSearchParams,
            then: ((AnimalSearchResult) -> Void)?,
            fail: ((Error) -> Void)?) {
        // No-op for now
    }

    func searchGifs(with params: SearchParams,
            then: ((SearchResult) -> Void)?,
            fail: ((Error) -> Void)?) {
        // if function passed in as 'then' exists, make it the callback function and then call the callback function
        if let callback = then {
            callback(SearchResult(data: [
                Gif(id: "FiGiRei2ICzzG", source_tld: "tumblr.com", images: Images(
                    fixed_width: FixedWidth(url: "http://media2.giphy.com/media/FiGiRei2ICzzG/200w.gif")
                ))
            ]))
        }
    }
}
