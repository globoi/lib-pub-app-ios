import GoogleMobileAds
import PrebidMobile

public struct NativeAdResponseGeneric<T> {
    public let nativeCustomFormatAd: GADCustomNativeAd
    public let prebidNativeAd: NativeAd?
    public let payload: T
    public let interaction: IInteractionAdapter
}
