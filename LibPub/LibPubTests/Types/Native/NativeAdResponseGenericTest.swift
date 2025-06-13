import XCTest
import GoogleMobileAds
import PrebidMobile
@testable import LibPub

class NativeAdResponseGenericTests: XCTestCase {

    func testNativeAdResponseGenericInitialization() {
        let mockGADCustomNativeAd = MockGADCustomNativeAd()
        let mockPrebidNativeAd = MockNativeAd()
        let mockPayload = ["key": "value"]
        let mockInteraction = MockInteractionAdapter()

        let response = NativeAdResponseGeneric(
            nativeCustomFormatAd: mockGADCustomNativeAd,
            prebidNativeAd: mockPrebidNativeAd as? NativeAd,
            payload: mockPayload,
            interaction: mockInteraction
        )

        XCTAssertNotNil(response.nativeCustomFormatAd)
        XCTAssertNil(response.prebidNativeAd)
        XCTAssertNotNil(response.payload)
        XCTAssertNotNil(response.interaction)
    }

    func testNativeAdResponseGenericWithNilPrebidNativeAd() {
        let mockGADCustomNativeAd = MockGADCustomNativeAd()
        let mockPayload = "String payload"
        let mockInteraction = MockInteractionAdapter()

        let response = NativeAdResponseGeneric(
            nativeCustomFormatAd: mockGADCustomNativeAd,
            prebidNativeAd: nil,
            payload: mockPayload,
            interaction: mockInteraction
        )

        XCTAssertNotNil(response.nativeCustomFormatAd)
        XCTAssertNil(response.prebidNativeAd)
        XCTAssertNotNil(response.payload)
        XCTAssertNotNil(response.interaction)
    }

    func testNativeAdResponseGenericPayloadTypes() {
        let mockGADCustomNativeAd = MockGADCustomNativeAd()
        let mockInteraction = MockInteractionAdapter()

        let dictPayload = ["key": "value"]
        let dictResponse = NativeAdResponseGeneric(
            nativeCustomFormatAd: mockGADCustomNativeAd,
            prebidNativeAd: nil,
            payload: dictPayload,
            interaction: mockInteraction
        )
        XCTAssertEqual(dictResponse.payload, dictPayload)

        let arrayPayload = [1, 2, 3]
        let arrayResponse = NativeAdResponseGeneric(
            nativeCustomFormatAd: mockGADCustomNativeAd,
            prebidNativeAd: nil,
            payload: arrayPayload,
            interaction: mockInteraction
        )
        XCTAssertEqual(arrayResponse.payload, arrayPayload)

        let stringPayload = "Test payload"
        let stringResponse = NativeAdResponseGeneric(
            nativeCustomFormatAd: mockGADCustomNativeAd,
            prebidNativeAd: nil,
            payload: stringPayload,
            interaction: mockInteraction
        )
        XCTAssertEqual(stringResponse.payload, stringPayload)
    }
}
