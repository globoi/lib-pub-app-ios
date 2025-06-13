struct PrebidTemplateIdRepository {
    static func getTemplateIdByAdType(adType: AdType, device: Device) -> String {
        switch device {
        case .APP:
            switch adType {
            case .PAUSE_AD:
                return Constants.PauseAds.PrebidTemplateID
            case .BINGE_AD:
                return Constants.BingeAds.PrebidTemplateID
            }
        }
    }
}
