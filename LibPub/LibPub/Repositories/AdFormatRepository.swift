import GoogleMobileAds
import PrebidMobile

struct AdFormatRepository {
    static let adFormatPayloads: [AdType: (GADCustomNativeAd, NativeAd?) -> Any] = [
        .PAUSE_AD: generatePauseAdPayload,
        .BINGE_AD: generateBingeAdPayload
    ]

    static func getAdFormatByType<T>(
        adType: AdType,
        nativeAdResponse: NativeAdResponse
    ) throws -> NativeAdResponseGeneric<T> {
        guard let payloadGenerator = adFormatPayloads[adType] else {
            throw NSError(domain: "AdFormatRepository", code: 1, userInfo: [NSLocalizedDescriptionKey: "Ad type not found: \(adType)"])
        }

        let payload = payloadGenerator(nativeAdResponse.nativeCustomFormatAd, nativeAdResponse.prebidNativeAd)

        guard let typedPayload = payload as? T else {
            throw NSError(domain: "AdFormatRepository", code: 2, userInfo: [NSLocalizedDescriptionKey: "Failed to cast payload to expected type for ad type: \(adType)"])
        }

        return NativeAdResponseGeneric<T>(
            nativeCustomFormatAd: nativeAdResponse.nativeCustomFormatAd,
            prebidNativeAd: nativeAdResponse.prebidNativeAd,
            payload: typedPayload,
            interaction: nativeAdResponse.interaction
        )
    }
}
