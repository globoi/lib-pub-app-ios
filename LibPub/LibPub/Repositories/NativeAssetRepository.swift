import PrebidMobile

struct NativeAssetRepository {
    static func getNativeAssetByAdType(adType: AdType, adUnit: String) -> AdUnit {
        switch adType {
        case .PAUSE_AD:
            return getPauseAdNativeAdUnit(adUnit: adUnit)
        case .BINGE_AD:
            return getBingeAdNativeAdUnit(adUnit: adUnit)
        }
    }
}
