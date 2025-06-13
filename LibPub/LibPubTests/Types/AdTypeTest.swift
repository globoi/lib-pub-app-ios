import XCTest
@testable import LibPub

class AdTypeTests: XCTestCase {

    func testAdTypeRawValues() {
        XCTAssertEqual(AdType.PAUSE_AD.rawValue, "pause_ad")
        XCTAssertEqual(AdType.BINGE_AD.rawValue, "binge_ad")
    }

    func testAdTypeInitialization() {
        XCTAssertEqual(AdType(rawValue: "pause_ad"), .PAUSE_AD)
        XCTAssertEqual(AdType(rawValue: "binge_ad"), .BINGE_AD)
    }

    func testAdTypeInvalidInitialization() {
        XCTAssertNil(AdType(rawValue: "invalid_ad"))
    }

}
