import GoogleMobileAds
import PrebidMobile

internal func getBingeAdNativeAdUnit(adUnit: String) -> AdUnit {
    let assets = getBingeAdNativeAssets()
    let eventTrackers = [NativeEventTracker(event: .Impression, methods: [.Image, .js])]
    let request = NativeRequest(configId: adUnit, assets: assets, eventTrackers: eventTrackers)
    request.context = .Content
    request.contextSubType = .Video
    request.placementType = .OutsideContent

    return request
}

internal func getBingeAdNativeAssets() -> [NativeAsset] {
    let imageAsset = NativeAssetImage(minimumWidth: 1, minimumHeight: 1, required: true)
    imageAsset.type = .Main

    let iconAsset = NativeAssetImage(minimumWidth: 1, minimumHeight: 1, required: true)
    iconAsset.type = .Icon

    return [imageAsset, iconAsset]
}

internal func generateBingeAdPayload(
    nativeCustomFormatAd: GADCustomNativeAd,
    prebidNativeAd: NativeAd?
) -> BingeAdPayload {
    if let prebidNativeAd = prebidNativeAd {
        return BingeAdPayload(
            imageUrl: prebidNativeAd.imageUrl ?? "",
            logoUrl: prebidNativeAd.iconUrl ?? ""
        )
    } else {
        return BingeAdPayload(
            imageUrl: nativeCustomFormatAd.image(forKey: "imagem")?.imageURL?.absoluteString ?? "",
            logoUrl: nativeCustomFormatAd.image(forKey: "logo")?.imageURL?.absoluteString ?? ""
        )
    }
}
