import GoogleMobileAds
import PrebidMobile

public protocol IInteractionAdapter {
    func recordImpression()
    func performClick(assetName: String)
    func startViewability(adView: UIView)
}

public struct InteractionAdapter: IInteractionAdapter {
    private let nativeCustomFormatAd: GADCustomNativeAd

    init(nativeCustomFormatAd: GADCustomNativeAd,
         prebidNativeAd: NativeAd? = nil,
         containerView: UIView? = nil,
         clickableViews: [UIView]? = nil) {

        self.nativeCustomFormatAd = nativeCustomFormatAd

        if prebidNativeAd != nil && containerView != nil && clickableViews != nil {
            prebidNativeAd?.registerView(view: containerView, clickableViews: clickableViews)
        }
    }

    public func recordImpression() {
        nativeCustomFormatAd.recordImpression()
    }

    public func performClick(assetName: String) {
        nativeCustomFormatAd.performClickOnAsset(withKey: assetName)
    }

    public func startViewability(adView: UIView) {
        nativeCustomFormatAd.displayAdMeasurement?.view = adView
        do {
            try? nativeCustomFormatAd.displayAdMeasurement?.start()
        }
    }
}
