import GoogleMobileAds
import PrebidMobile

public struct NativeAdResponse {
    let nativeCustomFormatAd: GADCustomNativeAd
    let prebidNativeAd: NativeAd?
    let interaction: IInteractionAdapter
}
