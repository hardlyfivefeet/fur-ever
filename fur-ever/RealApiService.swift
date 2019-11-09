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
        $0.headers["Authorization"] = "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjZkYjcwNWM3ZDVjNTM2MzBmMjlhMDI1ODBjZTI0Y2VkNzVmMzEzZjAxZWVmMTVmMzk5NWFhODk5NDg0YmQ0OWIyMTBmNWMzY2U0MzBiMDY0In0.eyJhdWQiOiJwb29hQmViTEc5MWFyMzFXZ01nbU42VVhsNExYc3ZGYkNSSXd4YzNWUUs5QThlMjdTciIsImp0aSI6IjZkYjcwNWM3ZDVjNTM2MzBmMjlhMDI1ODBjZTI0Y2VkNzVmMzEzZjAxZWVmMTVmMzk5NWFhODk5NDg0YmQ0OWIyMTBmNWMzY2U0MzBiMDY0IiwiaWF0IjoxNTczMjg0ODI0LCJuYmYiOjE1NzMyODQ4MjQsImV4cCI6MTU3MzI4ODQyNCwic3ViIjoiIiwic2NvcGVzIjpbXX0.a3VwKd2WOGcRzDfoBfArZ75Emv1jb1HWmyhHvaP_Y1A14g_tSlQchi50fNe5NSoDDx5gO3ABiCI-D7S3uWz1oIlcmN3YJ0T-BxdMHSQdrJhZyJENfBBF-Uja03V5b6LfP6tQzTa-QLW9ICHYkqQWt-Ck0PH7YSjc6e8WAhdl-eGvTiMtkB2nL7uJ4wR7QTW7s2SpkgHTybTbQCJq7ToZ_HSuJ0Hos49D0csFLl03QsGW3DIil6V1_cnwqLsrYU-iUxJwE7LSvTWvvEcDoq1EVgstXe5Ztb8KUV4KL2T19LJOemsW3FqReJN52fc59UmlM55CmRUaVZMQT2U_UMTr0A"
        }

        let jsonDecoder = JSONDecoder()

        // Map specific API endpoints to different models
        service.configureTransformer("/animals") {
            try jsonDecoder.decode(AnimalSearchResult.self, from: $0.content)
        }
    }

    func searchAnimals(with params: AnimalSearchParams,
                then: ((AnimalSearchResult) -> Void)?,
                fail: ((Error) -> Void)?) {
//        let appliedBreedFilters = getAppliedFilterValues(with: params.breeds)
//        let appliedAgeFilters = getAppliedFilterValues(with: params.age)
//        let appliedSizeFilters = getAppliedFilterValues(with: params.size)
//        let appliedGenderFilters = getAppliedFilterValues(with: params.gender)
        let distance = String(params.distance)
//        let organizationId = params.organizationId ?? ""

        service.resource("/animals")
            .withParam("type", params.animalType)
            .withParam("location", params.location)
            .withParam("limit", "100")
//            .withParam("breed", appliedBreedFilters)
//            .withParam("size", appliedSizeFilters)
//            .withParam("gender", appliedGenderFilters)
//            .withParam("age", appliedAgeFilters)
//            .withParam("organization", organizationId)
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
        // TODO: Implement API call
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
