import XCTest
@testable import LibPub

class LibPubAppConfigTests: XCTestCase {

    func testInitWithDefaultValue() {
        let config = LibPubAppConfig()
        XCTAssertTrue(config.withPrebid, "withPrebid deve ser true por padrão")
    }

    func testInitWithTrueValue() {
        let config = LibPubAppConfig(withPrebid: true)
        XCTAssertTrue(config.withPrebid, "withPrebid deve ser true quando explicitamente definido como true")
    }

    func testInitWithFalseValue() {
        let config = LibPubAppConfig(withPrebid: false)
        XCTAssertFalse(config.withPrebid, "withPrebid deve ser false quando explicitamente definido como false")
    }
}
