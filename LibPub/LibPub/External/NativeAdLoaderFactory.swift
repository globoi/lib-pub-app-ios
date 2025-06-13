import GoogleMobileAds

struct NativeAdLoaderFactory {
    static func createAdLoader(adUnit: String) -> GADAdLoader {
        return GADAdLoader(
            adUnitID: adUnit,
            rootViewController: nil,
            adTypes: [.customNative],
            options: nil
        )
    }
}
