import GoogleMobileAds
import PrebidMobile

internal func getPauseAdNativeAdUnit(adUnit: String) -> AdUnit {
    let assets = getPauseAdNativeAssets()
    let eventTrackers = [NativeEventTracker(event: .Impression, methods: [.Image, .js])]
    let request = NativeRequest(configId: adUnit, assets: assets, eventTrackers: eventTrackers)
    request.context = .Content
    request.contextSubType = .Video
    request.placementType = .OutsideContent

    return request
}

internal func getPauseAdNativeAssets() -> [NativeAsset] {
    let imageAsset = NativeAssetImage(minimumWidth: 1, minimumHeight: 1, required: true)
    imageAsset.type = .Main

    return [imageAsset]
}

internal func generatePauseAdPayload(
    nativeCustomFormatAd: GADCustomNativeAd,
    prebidNativeAd: NativeAd?
) -> PauseAdPayload {
    if let prebidNativeAd = prebidNativeAd {
        return PauseAdPayload(
            imageUrl: prebidNativeAd.imageUrl ?? ""
        )
    } else {
        return PauseAdPayload(
            imageUrl: nativeCustomFormatAd.image(forKey: "imagem")?.imageURL?.absoluteString ?? ""
        )
    }
}
