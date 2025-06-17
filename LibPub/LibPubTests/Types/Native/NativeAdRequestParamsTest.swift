import XCTest
import GoogleMobileAds
import PrebidMobile
@testable import LibPub

class NativeAdRequestParamsTests: XCTestCase {

    protocol AdUnitProtocol {}

    struct MockAdUnit: AdUnitProtocol {}

    func testNativeAdRequestParamsInitialization() {
        let adType = AdType.PAUSE_AD
        let adUnit = "test_ad_unit"
        let templateId = "test_template_id"
        let customTargeting = ["key1": "value1", "key2": "value2"]
        let gamRequest = AdRequestFactory.createAdRequest(customTargeting: customTargeting)
        let prebidOptions = PrebidOptions(adUnit: "config123")
        let prebidNativeAdUnit = MockAdUnit()
        let prebidTemplateId = "prebid_template_id"

        let params = NativeAdRequestParams(
            adType: adType,
            adUnit: adUnit,
            templateId: templateId,
            gamRequest: gamRequest,
            prebidOptions: prebidOptions,
            prebidNativeAdUnit: prebidNativeAdUnit as? AdUnit,
            prebidTemplateId: prebidTemplateId
        )

        XCTAssertEqual(params.adUnit, adUnit)
        XCTAssertEqual(params.templateId, templateId)
        XCTAssertNotNil(params.gamRequest)
        XCTAssertEqual(params.prebidOptions?.adUnit, prebidOptions.adUnit)
        XCTAssertNil(params.prebidNativeAdUnit)
        XCTAssertEqual(params.prebidTemplateId, prebidTemplateId)
    }

    func testNativeAdRequestParamsWithMinimalParameters() {
        let adType = AdType.PAUSE_AD
        let adUnit = "minimal_ad_unit"
        let templateId = "minimal_template_id"
        let gamRequest = AdRequestFactory.createAdRequest()

        let params = NativeAdRequestParams(
            adType: adType,
            adUnit: adUnit,
            templateId: templateId,
            gamRequest: gamRequest,
            prebidOptions: nil,
            prebidNativeAdUnit: nil,
            prebidTemplateId: nil
        )

        XCTAssertEqual(params.adUnit, adUnit)
        XCTAssertEqual(params.templateId, templateId)
        XCTAssertNotNil(params.gamRequest)
        XCTAssertNil(params.prebidOptions)
        XCTAssertNil(params.prebidNativeAdUnit)
        XCTAssertNil(params.prebidTemplateId)
    }

    func testNativeAdRequestParamsWithPartialOptionalParameters() {
        let adType = AdType.BINGE_AD
        let adUnit = "partial_ad_unit"
        let templateId = "partial_template_id"
        let customTargeting = ["key": "value"]
        let gamRequest = AdRequestFactory.createAdRequest(customTargeting: customTargeting)

        let params = NativeAdRequestParams(
            adType: adType,
            adUnit: adUnit,
            templateId: templateId,
            gamRequest: gamRequest,
            prebidOptions: nil,
            prebidNativeAdUnit: nil,
            prebidTemplateId: nil
        )

        XCTAssertEqual(params.adUnit, adUnit)
        XCTAssertEqual(params.templateId, templateId)
        XCTAssertNotNil(params.gamRequest)
        XCTAssertNil(params.prebidOptions)
        XCTAssertNil(params.prebidNativeAdUnit)
        XCTAssertNil(params.prebidTemplateId)
    }
}
