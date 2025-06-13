import GoogleMobileAds
import PrebidMobile
@testable import LibPub

protocol NativeAdProtocol {
    func registerView(view: UIView?, clickableViews: [UIView]?)
}

class MockGADCustomNativeAd: GADCustomNativeAd {
    override init() { super.init() }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

struct MockNativeAd: NativeAdProtocol {
    func registerView(view: UIView?, clickableViews: [UIView]?) {}
}

class MockInteractionAdapter: IInteractionAdapter {
    var startViewability = false
    var recordImpressionCalled = false
    var performClickCalled = false
    var performClickAssetName: String?
    var registerViewCalled = false

    func startViewability(adView: UIView) {
        var startViewability = true
    }
    
    func recordImpression() {
        recordImpressionCalled = true
    }

    func performClick(assetName: String) {
        performClickCalled = true
        performClickAssetName = assetName
    }
}
