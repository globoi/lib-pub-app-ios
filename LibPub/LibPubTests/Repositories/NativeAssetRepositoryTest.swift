import XCTest
import PrebidMobile
@testable import LibPub

class NativeAssetRepositoryTests: XCTestCase {

    func testGetNativeAssetForPauseAd() {
        let adUnit = "test_pause_ad_unit"
        let result = NativeAssetRepository.getNativeAssetByAdType(adType: .PAUSE_AD, adUnit: adUnit)
        XCTAssertNotNil(result)
    }

    func testGetNativeAssetForBingeAd() {
        let adUnit = "test_binge_ad_unit"
        let result = NativeAssetRepository.getNativeAssetByAdType(adType: .BINGE_AD, adUnit: adUnit)
        XCTAssertNotNil(result)
    }

}
