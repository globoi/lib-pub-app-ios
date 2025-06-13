import XCTest
@testable import LibPub

class NativeAdRequestOptionsTests: XCTestCase {

    func testNativeAdRequestOptionsInitialization() {
        let adType: AdType = .PAUSE_AD
        let adUnit = "test_ad_unit"
        let prebidOptions = PrebidOptions(adUnit: "123")
        let ppid = "user123"
        let customTargeting = ["key1": "value1", "key2": "value2"]

        let options = NativeAdRequestOptions(
            adType: adType,
            adUnit: adUnit,
            prebidOptions: prebidOptions,
            ppid: ppid,
            customTargeting: customTargeting
        )

        XCTAssertEqual(options.adType, adType)
        XCTAssertEqual(options.adUnit, adUnit)
        XCTAssertEqual(options.prebidOptions?.adUnit, prebidOptions.adUnit)
        XCTAssertEqual(options.ppid, ppid)
        XCTAssertEqual(options.customTargeting, customTargeting)
    }

    func testNativeAdRequestOptionsWithDefaultValues() {
        let adType: AdType = .BINGE_AD
        let adUnit = "default_ad_unit"

        let options = NativeAdRequestOptions(
            adType: adType,
            adUnit: adUnit
        )

        XCTAssertEqual(options.adType, adType)
        XCTAssertEqual(options.adUnit, adUnit)
        XCTAssertNil(options.prebidOptions)
        XCTAssertNil(options.ppid)
        XCTAssertNil(options.customTargeting)
    }

    func testNativeAdRequestOptionsWithPartialOptionalValues() {
        let adType: AdType = .PAUSE_AD
        let adUnit = "partial_ad_unit"
        let ppid = "user456"

        let options = NativeAdRequestOptions(
            adType: adType,
            adUnit: adUnit,
            ppid: ppid
        )

        XCTAssertEqual(options.adType, adType)
        XCTAssertEqual(options.adUnit, adUnit)
        XCTAssertNil(options.prebidOptions)
        XCTAssertEqual(options.ppid, ppid)
        XCTAssertNil(options.customTargeting)
    }
}
