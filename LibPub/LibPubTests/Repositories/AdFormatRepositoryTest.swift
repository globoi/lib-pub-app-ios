import XCTest
import GoogleMobileAds
import PrebidMobile
@testable import LibPub

class AdFormatRepositoryTests: XCTestCase {

    func testGetAdFormatByTypeForPauseAd() throws {
        let mockGADNativeAd = MockGADCustomNativeAd()
        let mockNativeAd = MockNativeAd()
        let mockInteraction = MockInteractionAdapter()
        let nativeAdResponse = NativeAdResponse(
            nativeCustomFormatAd: mockGADNativeAd,
            prebidNativeAd: mockNativeAd as? NativeAd,
            interaction: mockInteraction
        )

        do {
            let response: NativeAdResponseGeneric<PauseAdPayload> = try AdFormatRepository.getAdFormatByType(
                adType: .PAUSE_AD,
                nativeAdResponse: nativeAdResponse
            )
            XCTAssertNotNil(response.payload)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    func testGetAdFormatByTypeForBingeAd() throws {
        let mockGADNativeAd = MockGADCustomNativeAd()
        let mockNativeAd = MockNativeAd()
        let mockInteraction = MockInteractionAdapter()
        let nativeAdResponse = NativeAdResponse(
            nativeCustomFormatAd: mockGADNativeAd,
            prebidNativeAd: mockNativeAd as? NativeAd,
            interaction: mockInteraction
        )

        do {
            let response: NativeAdResponseGeneric<BingeAdPayload> = try AdFormatRepository.getAdFormatByType(
                adType: .BINGE_AD,
                nativeAdResponse: nativeAdResponse
            )
            XCTAssertNotNil(response.payload)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    func testAllDefinedAdTypesHavePayloadGenerators() {
        let definedAdTypes: [AdType] = [.PAUSE_AD, .BINGE_AD]
        for adType in definedAdTypes {
            XCTAssertNotNil(AdFormatRepository.adFormatPayloads[adType])
        }
    }
}
