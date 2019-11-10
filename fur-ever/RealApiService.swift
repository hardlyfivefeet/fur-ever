import Siesta
import OAuth2

class RealApiService: Api {

    private var service = Service(
        baseURL: "https://www.petfinder.com",
        standardTransformers: [.text, .image])

    private var authToken: String?

    init() {
        // Bare-bones logging of which network calls Siesta makes:
        SiestaLog.Category.enabled = [.network]
//        SiestaLog.Category.enabled = SiestaLog.Category.all
    }

    func api(host: String) {
        service = Service(baseURL: host, standardTransformers: [.text, .image])
//        service.configure("**") {
//            if let authToken = self.authToken {
//                $0.headers["Authorization"] = "Bearer \(authToken)"
//            }
//        }

        service.configure("**") {
        $0.headers["Authorization"] = "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjY5MzNkOWVjMDg1NjFiM2I4ZDQ4ZjA1YmNjYzZjNTQ5NmRhOTc3MTJhMzI0NDdlOTczYzQxNjMyNGY1Yjc5MzEyNzZkOWI3NWNjN2Q2ZmEyIn0.eyJhdWQiOiJwb29hQmViTEc5MWFyMzFXZ01nbU42VVhsNExYc3ZGYkNSSXd4YzNWUUs5QThlMjdTciIsImp0aSI6IjY5MzNkOWVjMDg1NjFiM2I4ZDQ4ZjA1YmNjYzZjNTQ5NmRhOTc3MTJhMzI0NDdlOTczYzQxNjMyNGY1Yjc5MzEyNzZkOWI3NWNjN2Q2ZmEyIiwiaWF0IjoxNTczMzc2NTY4LCJuYmYiOjE1NzMzNzY1NjgsImV4cCI6MTU3MzM4MDE2OCwic3ViIjoiIiwic2NvcGVzIjpbXX0.mggrvgphJkjm2spdHt4YSj2qXQ_3gYDAGj-ldx6YDHypovDtDgeHdZVjWkx8N4uIAmWmJvzNSzCr4XGfhy1S0xleqBnK_yAF9vEKrlIMQZ15WNULDhXqLwg8Wd-tKo3wmCBiargvC-h8bCs6-aLzROa33cUlVQBpklmCoc-pMpjG7XwKk44-bojFEVwiwGGm0fxR9c7XC1STdLmCeBggmbNmX7d9shpmJWnu_YXF_YSW-2zIJcgqkOL9l68-Mvdd6IyAmsWcxvhTRjJGM6_CFla1JsiDU4FrqjQdHHVVZj_cQlBUpEQFgvUyi_iGyMRDVWChfBLJ8uOzlniUtBq2lA"
        }

        let jsonDecoder = JSONDecoder()

        // Map specific API endpoints to different models
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
