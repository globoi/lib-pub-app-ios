import GoogleMobileAds

// TODO: accept GAM Request as a parameter by uncommenting the lines below
public struct NativeAdRequestOptions {
    public let adType: AdType
    public let device: Device = Device.APP
    public let adUnit: String
    public let prebidOptions: PrebidOptions?
    public let ppid: String?
    public let customTargeting: [String: String]?

    public init(
        adType: AdType,
        adUnit: String,
        prebidOptions: PrebidOptions? = nil,
        ppid: String? = nil,
        customTargeting: [String: String]? = nil
    ) {
        self.adType = adType
        self.adUnit = adUnit
        self.prebidOptions = prebidOptions
        self.ppid = ppid
        self.customTargeting = customTargeting
    }
}
