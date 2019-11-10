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
        $0.headers["Authorization"] = "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjIxYWI1MjAzYTc4NjhlNzQxYjllMjYxOWY0MmNmNmQ4MDY4N2E4OTA5M2U3NTU3YWM5M2ZkZWFmNmRiYzZmYmNjMWViMTczNThiY2YwNDgxIn0.eyJhdWQiOiJwb29hQmViTEc5MWFyMzFXZ01nbU42VVhsNExYc3ZGYkNSSXd4YzNWUUs5QThlMjdTciIsImp0aSI6IjIxYWI1MjAzYTc4NjhlNzQxYjllMjYxOWY0MmNmNmQ4MDY4N2E4OTA5M2U3NTU3YWM5M2ZkZWFmNmRiYzZmYmNjMWViMTczNThiY2YwNDgxIiwiaWF0IjoxNTczMzQ0NjE2LCJuYmYiOjE1NzMzNDQ2MTYsImV4cCI6MTU3MzM0ODIxNiwic3ViIjoiIiwic2NvcGVzIjpbXX0.wdx_QlliXp3izuS7JTKrdDXNoZl3HGPx71CHznX0KHbm22CRiganL66yMaMxsdo3Invt_3rr2ze70TshH6joErOyke91KHhSBXii18R2cOBc1yhwhhpPCsBWsjvPW-cPpbQ3KU8mHStTfEfo28QWkQ2JE7qaKUWoG6eQlUu165qc_5P3VCfty_8zc8D8ctS4ntPpG7LTO-bNroNzRKONed4inCz_IcI1wzUT99EzSBscSefQ3b2zq5k4LtZDQQSoHQA4t4NujiV4d85Zc2B1uIrtseYJ_Oka4WLsZD3iVVacdgXcLsCrIFQDtf9NJ6bMyy_15mote-jD09KCFm7K_g"
        }

        let jsonDecoder = JSONDecoder()

        // Map specific API endpoints to different models
        service.configureTransformer("/animals") {
            try jsonDecoder.decode(AnimalSearchResult.self, from: $0.content)
        }
        service.configureTransformer("/animals/*") {
            try jsonDecoder.decode(AnimalResultInfo.self, from: $0.content)
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
        // TODO: Implement API call
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
