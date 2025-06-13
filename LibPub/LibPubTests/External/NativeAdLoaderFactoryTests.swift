import XCTest
import GoogleMobileAds
@testable import LibPub

class NativeAdLoaderFactoryTests: XCTestCase {
    func testCreateAdLoader() {
        let adUnit = "test_ad_unit_id"
        let adLoader = NativeAdLoaderFactory.createAdLoader(adUnit: adUnit)
        XCTAssertNotNil(adLoader)
        XCTAssertEqual(adLoader.adUnitID, adUnit)
        XCTAssertNil(adLoader.delegate)
    }
}
