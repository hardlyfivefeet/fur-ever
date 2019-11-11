import Siesta

class RealApiService: Api {

    private var service = Service(
        baseURL: "https://www.petfinder.com",
        standardTransformers: [.text, .image])

    private var authToken: Token?

    init() {
        // Bare-bones logging of which network calls Siesta makes:
        // SiestaLog.Category.enabled = [.network]
        // SiestaLog.Category.enabled = SiestaLog.Category.all
    }

    func api(host: String) {
        service = Service(baseURL: host, standardTransformers: [.text, .image])
        service.configure("**") {
            if let authToken = self.authToken {
                $0.headers["Authorization"] = "Bearer \(authToken.access_token)"
            }
        }

        let jsonDecoder = JSONDecoder()

        // Map specific API endpoints to different models
        service.configureTransformer("/oauth2/token") {
            try jsonDecoder.decode(Token.self, from: $0.content)
        }
        service.configureTransformer("/animals") {
            try jsonDecoder.decode(AnimalSearchResult.self, from: $0.content)
        }
        service.configureTransformer("/animals/*") {
            try jsonDecoder.decode(AnimalResultInfo.self, from: $0.content)
        }
        service.configureTransformer("/organizations") {
            try jsonDecoder.decode(OrganizationSearchResult.self, from: $0.content)
        }
    }

    func getToken(with params: TokenRequestParams,
    fail: ((Error) -> Void)?) {
        service.resource("/oauth2/token")
            .request(.post, urlEncoded: ["grant_type": params.grant_type, "client_id": params.client_id, "client_secret": params.client_secret])
            .onSuccess { entity in
            if let tokenReceived: Token = entity.typedContent() {
                self.authToken = tokenReceived
            }
        }.onFailure { error in
            if let callback = fail {
                callback(error)
            }
        }
    }

    func tokenHasExpired() -> Bool {
        return (self.authToken?.expires_in ?? 0 <= 0)
    }

    func searchAnimals(with params: AnimalSearchParams,
                then: ((AnimalSearchResult) -> Void)?,
                fail: ((Error) -> Void)?) {
        let appliedBreedFilters = getAppliedFilterValues(with: params.breeds)
        let appliedAgeFilters = getAppliedFilterValues(with: params.age)
        let appliedSizeFilters = getAppliedFilterValues(with: params.size)
        let appliedGenderFilters = getAppliedFilterValues(with: params.gender)
        let distance = String(params.distance)
        let organizationId = params.organizationId ?? ""

        service.resource("/animals")
            .withParam("type", params.animalType)
            .withParam("location", params.location)
            .withParam("limit", "100")
            .withParam("breed", appliedBreedFilters)
            .withParam("size", appliedSizeFilters)
            .withParam("gender", appliedGenderFilters)
            .withParam("age", appliedAgeFilters)
            .withParam("organization", organizationId)
            .withParam("distance", distance)
        .request(.get).onSuccess { result in
            if let animalSearchResult: AnimalSearchResult = result.typedContent(),
               let callback = then {
                callback(animalSearchResult)
            }
        }.onFailure { error in
            if let callback = fail {
                callback(error)
            }
        }
    }

    func getAnimal(with animalId: Int,
                then: ((AnimalResultInfo) -> Void)?,
                fail: ((Error) -> Void)?) {
        let path = "/animals/" + String(animalId)
        service.resource(path)
            .withParam("limit", "100")
        .request(.get).onSuccess { result in
            if let animalResultInfo: AnimalResultInfo = result.typedContent(),
               let callback = then {
                callback(animalResultInfo)
            }
        }.onFailure { error in
            if let callback = fail {
                callback(error)
            }
        }
    }

    func searchOrganizations(with params: OrganizationSearchParams,
                then: ((OrganizationSearchResult) -> Void)?,
                fail: ((Error) -> Void)?) {
        service.resource("/organizations")
            .withParam("name", params.name)
            .withParam("location", params.location)
            .withParam("limit", "100")
        .request(.get).onSuccess { result in
            if let organizationSearchResult: OrganizationSearchResult = result.typedContent(),
               let callback = then {
                callback(organizationSearchResult)
            }
        }.onFailure { error in
            if let callback = fail {
                callback(error)
            }
        }
    }

    private func getAppliedFilterValues(with filter: Filter?) -> String {
        if filter == nil {
            return ""
        }
        var result: String = ""
        for appliedFilter in filter!.appliedFilters {
            result.append(filter!.availableValues[appliedFilter])
            result.append(",")
        }
        // if string is not empty, remove the comma at the end
        if (result.count > 0) {
            result.remove(at: result.index(before: result.endIndex))
        }
        return result
    }
}
