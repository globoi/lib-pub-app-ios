import GoogleMobileAds
import PrebidMobile

// TODO: Add unit tests to LibPubApp
public class LibPubApp {
    private var config: LibPubAppConfig
    private var nativeAdRequestFactory: NativeAdRequestFactory?
    private static var sharedInstance: LibPubApp?

    private init(config: LibPubAppConfig) {
        self.config = config
        self.applyConfig()
    }

    public static func configure(options: LibPubAppConfig = LibPubAppConfig()) {
        if sharedInstance == nil {
            sharedInstance = LibPubApp(config: options)
        }
    }

    private func applyConfig() {
        if config.withPrebid {
            self.initPrebidSDK()
        }
    }

    public static func instance() -> LibPubApp {
        guard let instance = sharedInstance else {
            fatalError("LibPubApp must be configured before accessing the instance.")
        }
        return instance
    }

    private func initPrebidSDK() {
        log("Initializing Prebid SDK...")
        Prebid.shared.pbsDebug = false
        Prebid.shared.prebidServerAccountId = Constants.PrebidAccountID
        Prebid.shared.prebidServerHost = .Rubicon
        Prebid.shared.timeoutMillis = 3000
        Prebid.shared.includeWinners = true
    }

    public func requestAd<T>(nativeAdRequestOptions: NativeAdRequestOptions) async throws -> NativeAdResponseGeneric<T> {
        log("Starting to load the AD")

        if let customTargeting = nativeAdRequestOptions.customTargeting {
            _ = TargetingValidator.validate(targeting: customTargeting)
        }

        let nativeAdRequest = NativeAdRequestFactory.createAdRequest(
            adType: nativeAdRequestOptions.adType,
            adUnit: nativeAdRequestOptions.adUnit,
            prebidOptions: nativeAdRequestOptions.prebidOptions,
            ppid: nativeAdRequestOptions.ppid,
            customTargeting: nativeAdRequestOptions.customTargeting
        )

        let nativeAdResponse = try await nativeAdRequest.requestAd()

        let adResponseGeneric: NativeAdResponseGeneric<T> = try AdFormatRepository.getAdFormatByType(
            adType: nativeAdRequestOptions.adType,
            nativeAdResponse: nativeAdResponse
        )

        return adResponseGeneric
    }
}
