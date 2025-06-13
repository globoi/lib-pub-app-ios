import XCTest
@testable import LibPub

class DeviceTests: XCTestCase {

    func testDeviceRawValue() {
        XCTAssertEqual(Device.APP.rawValue, "app")
    }

    func testDeviceInitialization() {
        XCTAssertEqual(Device(rawValue: "app"), .APP)
    }

    func testDeviceInvalidInitialization() {
        XCTAssertNil(Device(rawValue: "invalid_device"))
    }

}
