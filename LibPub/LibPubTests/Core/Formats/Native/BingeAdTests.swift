import XCTest
import GoogleMobileAds
import PrebidMobile
@testable import LibPub

class BingeAdTests: XCTestCase {

    func testGetBingeAdNativeAdUnit() {
        let adUnit = "test_ad_unit"
        let nativeAdUnit = getBingeAdNativeAdUnit(adUnit: adUnit)
        XCTAssertTrue(nativeAdUnit is NativeRequest)

        let request = nativeAdUnit as! NativeRequest
        XCTAssertEqual(request.configId, adUnit)
        XCTAssertEqual(request.context, .Content)
        XCTAssertEqual(request.contextSubType, .Video)
        XCTAssertEqual(request.placementType, .OutsideContent)
        XCTAssertEqual(request.assets?.count, 2)
        XCTAssertEqual(request.eventtrackers?.count, 1)
    }

    func testGetBingeAdNativeAssets() {
        let assets = getBingeAdNativeAssets()
        XCTAssertEqual(assets.count, 2)

        let imageAsset = assets[0] as? NativeAssetImage
        XCTAssertNotNil(imageAsset)
        XCTAssertEqual(imageAsset?.type, .Main)
        XCTAssertEqual(imageAsset?.widthMin, 1)
        XCTAssertEqual(imageAsset?.heightMin, 1)
        XCTAssertTrue(imageAsset?.required ?? false)

        let iconAsset = assets[1] as? NativeAssetImage
        XCTAssertNotNil(iconAsset)
        XCTAssertEqual(iconAsset?.type, .Icon)
        XCTAssertEqual(iconAsset?.widthMin, 1)
        XCTAssertEqual(iconAsset?.heightMin, 1)
        XCTAssertTrue(iconAsset?.required ?? false)
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
