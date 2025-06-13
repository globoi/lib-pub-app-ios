import XCTest
@testable import LibPub

class PrebidOptionsTests: XCTestCase {

    func testPrebidOptionsInitialization() {
        let adUnit = "test_ad_unit"
        let options = PrebidOptions(adUnit: adUnit)
        XCTAssertEqual(options.adUnit, adUnit)
    }

    func testPrebidOptionsWithEmptyAdUnit() {
        let options = PrebidOptions(adUnit: "")
        XCTAssertEqual(options.adUnit, "")
    }

}
