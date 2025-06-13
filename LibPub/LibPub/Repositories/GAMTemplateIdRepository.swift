struct GAMTemplateIdRepository {
    static func getTemplateIdByAdType(adType: AdType, device: Device) -> String {
        switch device {
        case .APP:
            switch adType {
            case .PAUSE_AD:
                return Constants.PauseAds.GAMTemplateID
            case .BINGE_AD:
                return Constants.BingeAds.GAMTemplateID
            }
        }
    }
}
