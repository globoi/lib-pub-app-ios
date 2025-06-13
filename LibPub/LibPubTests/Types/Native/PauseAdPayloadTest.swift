import XCTest
@testable import LibPub

class PauseAdPayloadTests: XCTestCase {

    func testPauseAdPayloadInitialization() {
        let imageUrl = "https://example.com/pause_image.jpg"
        let payload = PauseAdPayload(imageUrl: imageUrl)
        XCTAssertEqual(payload.imageUrl, imageUrl)
    }

    func testPauseAdPayloadWithEmptyUrl() {
        let payload = PauseAdPayload(imageUrl: "")
        XCTAssertEqual(payload.imageUrl, "")
    }

}
