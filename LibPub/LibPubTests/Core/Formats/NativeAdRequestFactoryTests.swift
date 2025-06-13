import XCTest
import GoogleMobileAds
import PrebidMobile
@testable import LibPub

// MARK: - Pause Ad Tests
class NativePauseAdRequestFactoryTests: XCTestCase {
    func testCreatePauseAdRequestWithPrebid() {
        let adType: AdType = .PAUSE_AD
        let adUnit = "pause_ad_unit"
        let prebidOptions = PrebidOptions(adUnit: "prebid_pause_ad_unit")

        let request = NativeAdRequestFactory.createAdRequest(
            adType: adType,
            adUnit: adUnit,
            prebidOptions: prebidOptions
        )

        XCTAssertNotNil(request)
        XCTAssertEqual(request.params.adUnit, adUnit)
        XCTAssertNotNil(request.params.prebidOptions)
        XCTAssertNotNil(request.params.prebidNativeAdUnit)
        XCTAssertEqual(request.params.prebidTemplateId, PrebidTemplateIdRepository.getTemplateIdByAdType(adType: adType, device: .APP))
    }

    func testCreatePauseAdRequestWithoutPrebid() {
        let adType: AdType = .PAUSE_AD
        let adUnit = "pause_ad_unit"

        let request = NativeAdRequestFactory.createAdRequest(
            adType: adType,
            adUnit: adUnit
        )

        XCTAssertNotNil(request)
        XCTAssertEqual(request.params.adUnit, adUnit)
        XCTAssertNil(request.params.prebidOptions)
        XCTAssertNil(request.params.prebidNativeAdUnit)
        XCTAssertNil(request.params.prebidTemplateId)
    }
}

// MARK: - Binge Ad Tests
class NativeBingeAdRequestFactoryTests: XCTestCase {
    func testCreateBingeAdRequestWithPrebid() {
        let adType: AdType = .BINGE_AD
        let adUnit = "binge_ad_unit"
        let prebidOptions = PrebidOptions(adUnit: "prebid_binge_ad_unit")

        let request = NativeAdRequestFactory.createAdRequest(
            adType: adType,
            adUnit: adUnit,
            prebidOptions: prebidOptions
        )

        XCTAssertNotNil(request)
        XCTAssertEqual(request.params.adUnit, adUnit)
        XCTAssertNotNil(request.params.prebidOptions)
        XCTAssertNotNil(request.params.prebidNativeAdUnit)
        XCTAssertEqual(request.params.prebidTemplateId, PrebidTemplateIdRepository.getTemplateIdByAdType(adType: adType, device: .APP))
    }

    func testCreateBingeAdRequestWithoutPrebid() {
        let adType: AdType = .BINGE_AD
        let adUnit = "binge_ad_unit"

        let request = NativeAdRequestFactory.createAdRequest(
            adType: adType,
            adUnit: adUnit
        )

        XCTAssertNotNil(request)
        XCTAssertEqual(request.params.adUnit, adUnit)
        XCTAssertNil(request.params.prebidOptions)
        XCTAssertNil(request.params.prebidNativeAdUnit)
        XCTAssertNil(request.params.prebidTemplateId)
    }
}
