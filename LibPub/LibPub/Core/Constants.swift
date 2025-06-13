enum Constants {

    static var PrebidAccountID: String { "11366-globoplayapp" }

    enum PauseAds {
        static var GAMTemplateID: String {
            #if DEBUG
            return "12198352"
            #else
            return "12198352"
            #endif
        }
        static var PrebidTemplateID: String {
            #if DEBUG
            return "12365901"
            #else
            return "12365901"
            #endif
        }
    }

    enum BingeAds {
        static var GAMTemplateID: String {
            #if DEBUG
            return "12295596"
            #else
            return "12295596"
            #endif
        }
        static var PrebidTemplateID: String {
            #if DEBUG
            return "12365901"
            #else
            return "12365901"
            #endif
        }
    }
}
