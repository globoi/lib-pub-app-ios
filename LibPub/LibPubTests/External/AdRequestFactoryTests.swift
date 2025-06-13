import XCTest
import GoogleMobileAds
@testable import LibPub

class AdRequestFactoryTests: XCTestCase {

    func testCreateAdRequestWithNoParameters() {
        let request = AdRequestFactory.createAdRequest()
        XCTAssertNotNil(request)
        XCTAssertNil(request.customTargeting)
        XCTAssertNil(request.publisherProvidedID)
    }

    func testCreateAdRequestWithCustomTargeting() {
        let customTargeting = ["key1": "value1", "key2": "value2"]
        let request = AdRequestFactory.createAdRequest(customTargeting: customTargeting)
        XCTAssertNotNil(request)
        XCTAssertEqual(request.customTargeting, customTargeting)
        XCTAssertNil(request.publisherProvidedID)
    }

    func testCreateAdRequestWithPPID() {
        let ppid = "test_ppid"
        let request = AdRequestFactory.createAdRequest(ppid: ppid)
        XCTAssertNotNil(request)
        XCTAssertNil(request.customTargeting)
        XCTAssertEqual(request.publisherProvidedID, ppid)
    }

    func testCreateAdRequestWithCustomTargetingAndPPID() {
        let customTargeting = ["key": "value"]
        let ppid = "test_ppid"
        let request = AdRequestFactory.createAdRequest(customTargeting: customTargeting, ppid: ppid)
        XCTAssertNotNil(request)
        XCTAssertEqual(request.customTargeting, customTargeting)
        XCTAssertEqual(request.publisherProvidedID, ppid)
    }
}
