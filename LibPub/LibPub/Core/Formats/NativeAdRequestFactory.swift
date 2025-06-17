import GoogleMobileAds
import PrebidMobile

public struct NativeAdRequestFactory {

    static func createAdRequest(
        adType: AdType,
        adUnit: String,
        prebidOptions: PrebidOptions? = nil,
        ppid: String? = nil,
        customTargeting: [String: String]? = nil
    ) -> NativeAdRequest {
        let gamRequest = AdRequestFactory.createAdRequest(
            customTargeting: customTargeting,
            ppid: ppid
        )

        let templateId = GAMTemplateIdRepository.getTemplateIdByAdType(
            adType: adType,
            device: .APP
        )

        let prebidTemplateId = prebidOptions != nil
            ? PrebidTemplateIdRepository.getTemplateIdByAdType(
                adType: adType,
                device: .APP
            )
            : nil

        var prebidNativeAdUnit: AdUnit? = nil
        if let prebidAdUnit = prebidOptions?.adUnit {
            prebidNativeAdUnit = NativeAssetRepository.getNativeAssetByAdType(
                adType: adType,
                adUnit: prebidAdUnit
            )
        }

        let params = NativeAdRequestParams(
            adType: adType,
            adUnit: adUnit,
            templateId: templateId,
            gamRequest: gamRequest,
            prebidOptions: prebidOptions,
            prebidNativeAdUnit: prebidNativeAdUnit,
            prebidTemplateId: prebidTemplateId
        )

        return NativeAdRequest(params: params)
    }
}
