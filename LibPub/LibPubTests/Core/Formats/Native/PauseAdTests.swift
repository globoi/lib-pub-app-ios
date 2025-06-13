import XCTest
import GoogleMobileAds
import PrebidMobile
@testable import LibPub

class PauseAdTests: XCTestCase {

    func testGetPauseAdNativeAdUnit() {
        let adUnit = "test_ad_unit"
        let nativeAdUnit = getPauseAdNativeAdUnit(adUnit: adUnit)
        XCTAssertTrue(nativeAdUnit is NativeRequest)

        let request = nativeAdUnit as! NativeRequest
        XCTAssertEqual(request.configId, adUnit)
        XCTAssertEqual(request.context, .Content)
        XCTAssertEqual(request.contextSubType, .Video)
        XCTAssertEqual(request.placementType, .OutsideContent)
        XCTAssertEqual(request.assets?.count, 1)
        XCTAssertEqual(request.eventtrackers?.count, 1)
    }

    func testGetPauseAdNativeAssets() {
        let assets = getPauseAdNativeAssets()
        XCTAssertEqual(assets.count, 1)

        let imageAsset = assets[0] as? NativeAssetImage
        XCTAssertNotNil(imageAsset)
        XCTAssertEqual(imageAsset?.type, .Main)
        XCTAssertEqual(imageAsset?.widthMin, 1)
        XCTAssertEqual(imageAsset?.heightMin, 1)
        XCTAssertTrue(imageAsset?.required ?? false)
    }

    // TODO implement testGenerateBingeAdPayloadWithPrebidNativeAd
    func testGenerateBingeAdPayloadWithPrebidNativeAd() {
        XCTSkip("Test not yet implemented")
    }

    // TODO implement testGenerateBingeAdPayloadWithGADCustomNativeAd
    func testGenerateBingeAdPayloadWithGADCustomNativeAd() {
        XCTSkip("Test not yet implemented")
    }

}
