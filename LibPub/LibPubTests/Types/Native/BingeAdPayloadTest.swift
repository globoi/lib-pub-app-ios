import XCTest
@testable import LibPub

class BingeAdPayloadTests: XCTestCase {

    func testBingeAdPayloadInitialization() {
        let imageUrl = "https://example.com/image.jpg"
        let logoUrl = "https://example.com/logo.png"

        let payload = BingeAdPayload(imageUrl: imageUrl, logoUrl: logoUrl)

        XCTAssertEqual(payload.imageUrl, imageUrl)
        XCTAssertEqual(payload.logoUrl, logoUrl)
    }

    func testBingeAdPayloadWithEmptyUrls() {
        let payload = BingeAdPayload(imageUrl: "", logoUrl: "")

        XCTAssertEqual(payload.imageUrl, "")
        XCTAssertEqual(payload.logoUrl, "")
    }

}
