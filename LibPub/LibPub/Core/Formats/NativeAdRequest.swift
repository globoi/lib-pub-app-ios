import GoogleMobileAds
import PrebidMobile

class NativeAdRequest {
    let params: NativeAdRequestParams
    private var adLoader: GADAdLoader!
    private var gamNativeAdLoader: GamNativeAdLoader?

    init(params: NativeAdRequestParams) {
        self.params = params
    }

    public func requestAd() async throws -> NativeAdResponse {
        return try await withCheckedThrowingContinuation { continuation in
            if let prebidRequest = params.prebidNativeAdUnit {
                prebidRequest.fetchDemand(adObject: params.gamRequest) { result in
                    if result == .prebidDemandFetchSuccess {
                        log("Prebid AD received successfully. ✅")
                    } else {
                        log("Prebid AD not received. 🚫")
                    }
                    self.callGamAdLoader(continuation: continuation)
                }
            } else {
                log("Prebid AdUnit not found.")
                self.callGamAdLoader(continuation: continuation)
            }
        }
    }

    private func callGamAdLoader(continuation: CheckedContinuation<NativeAdResponse, Error>) {
        let gamNativeAdLoader = GamNativeAdLoader(params: params) { result in
            self.gamNativeAdLoader = nil

            switch result {
            case .success(let nativeAdResponse):
                continuation.resume(returning: nativeAdResponse)
            case .failure(let error):
                continuation.resume(throwing: error)
            }
        }

        log("Calling GAM.")
        self.gamNativeAdLoader = gamNativeAdLoader
        self.adLoader = NativeAdLoaderFactory.createAdLoader(adUnit: params.adUnit)
        self.adLoader.delegate = gamNativeAdLoader
        self.adLoader.load(params.gamRequest)
    }
}

class GamNativeAdLoader: NSObject, GADAdLoaderDelegate, GADCustomNativeAdLoaderDelegate {
    let params: NativeAdRequestParams
    private let completion: (Result<NativeAdResponse, Error>) -> Void

    init(params: NativeAdRequestParams, completion: @escaping (Result<NativeAdResponse, Error>) -> Void) {
        self.params = params
        self.completion = completion
        super.init()
    }

    deinit {
        log("GamNativeAdLoader has been freed!")
    }

    public func adLoader(_ adLoader: GADAdLoader, didReceive customNativeAd: GADCustomNativeAd) {
        let prebidNativeAdDelegate = PrebidNativeAdDelegate()
        Utils.shared.delegate = prebidNativeAdDelegate
        Utils.shared.findNative(adObject: customNativeAd)

        let interaction = InteractionAdapter(
            nativeCustomFormatAd: customNativeAd,
            prebidNativeAd: prebidNativeAdDelegate.prebidNativeAd,
            containerView: self.params.prebidOptions?.containerView,
            clickableViews: self.params.prebidOptions?.clickableViews
        )

        let response: NativeAdResponse =
            NativeAdResponse(
                nativeCustomFormatAd: customNativeAd,
                prebidNativeAd: prebidNativeAdDelegate.prebidNativeAd,
                interaction: interaction
            )

        let hasPrebid = self.prebidBidsReceived()
        let hasImage = customNativeAd.availableAssetKeys.contains("imagem")

        if hasImage {
            if hasPrebid {
                log("Returned Prebid, but GAM opted for direct sale. 🟡")
            } else {
                log("Did not return Prebid, GAM opted for direct sale. 🟢")
            }
        } else if !hasImage && prebidBidsReceived() {
            log("Returned Prebid, GAM opted for Prebid. 🔵")
        } else {
            log("No ads to display. 🔴")
        }

        log("Ad successfully loaded.")
        completion(.success(response))
    }

    private func prebidBidsReceived() -> Bool {
        if let customTargeting = params.gamRequest.customTargeting {
            return customTargeting.keys.contains("hb_pb")
        }
        return false
    }

    public func adLoader(_ adLoader: GADAdLoader, didFailToReceiveAdWithError error: Error) {
        log("Failed loading ad: \(error.localizedDescription)")
        completion(.failure(error))
    }

    public func customNativeAdFormatIDs(for adLoader: GADAdLoader) -> [String] {
        if prebidBidsReceived() {
            if let templateId = self.params.prebidTemplateId {
                return [self.params.templateId, templateId]
            }
        }
        return [self.params.templateId]
    }
}

class PrebidNativeAdDelegate: NativeAdDelegate {
    deinit {
        log("PrebidNativeAdDelegate has been freed!")
    }

    var prebidNativeAd: NativeAd?
    func nativeAdLoaded(ad: NativeAd) {
        self.prebidNativeAd = ad
    }

    public func nativeAdNotFound() {}

    public func nativeAdNotValid() {}
}
