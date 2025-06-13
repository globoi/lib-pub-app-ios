import GoogleMobileAds

struct AdRequestFactory {
    static func createAdRequest(
        customTargeting: [String: String]? = nil,
        ppid: String? = nil
    ) -> GAMRequest {
        let gamRequest = GAMRequest()

        if let customTargeting = customTargeting {
            gamRequest.customTargeting = customTargeting
        }

        if let ppid = ppid {
            gamRequest.publisherProvidedID = ppid
        }

        return gamRequest
    }
}
