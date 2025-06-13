import UIKit

public struct PrebidOptions {
    let adUnit: String
    let containerView: UIView?
    let clickableViews: [UIView]?

    public init(adUnit: String, containerView: UIView? = nil, clickableViews: [UIView]? = nil) {
        self.adUnit = adUnit
        self.containerView = containerView
        self.clickableViews = clickableViews
    }
}
