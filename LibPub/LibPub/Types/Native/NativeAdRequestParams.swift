import GoogleMobileAds
import PrebidMobile

public struct NativeAdRequestParams {
    let adUnit: String
    let templateId: String
    let gamRequest: GAMRequest
    let prebidOptions: PrebidOptions?
    let prebidNativeAdUnit: AdUnit?
    let prebidTemplateId: String?
}
