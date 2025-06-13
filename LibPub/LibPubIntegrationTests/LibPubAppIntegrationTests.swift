import XCTest
@testable import LibPub

class LibPubAppIntegrationTests: XCTestCase {
    static let pauseAdUnit = "/95377733/Testes/Validacao/PauseAds-App"
    static let bingeAdUnit = "/95377733/Testes/Validacao/BingeAds-App"
    static let customTargetingPause = ["ambient": "app", "tvg_pos": "PAUSEAD"]
    static let customTargetingBinge = ["ambient": "app", "tvg_pos": "BINGEAD"]
    static let prebidAdUnit = "11366-imp-globoplay-ios_pause_ads"
    static let ppid = "9caf98bb6c2dd8c620b6f093a044269ade5e9786110f2598a54a78b5ec1207a7"
    static let timeout: TimeInterval = 10
    static let prebidOptions = PrebidOptions(
        adUnit: LibPubAppIntegrationTests.prebidAdUnit,
        containerView: UIView(),
        clickableViews: [UIView()]
    )

    // MARK: - Ad Request Test Helper
    func performAdRequestTest<T>(
        description: String,
        withPrebid: Bool,
        adType: AdType,
        adUnit: String,
        prebidOptions: PrebidOptions? = nil,
        ppid: String? = ppid,
        customTargeting: [String: String],
        expectedSuccess: Bool,
        payloadType: T.Type
    ) async where T: Any {
        LibPubApp.configure(options: LibPubAppConfig(withPrebid: withPrebid))

        let adOptions = NativeAdRequestOptions(
            adType: adType,
            adUnit: adUnit,
            prebidOptions: prebidOptions,
            ppid: ppid,
            customTargeting: customTargeting
        )

        do {
            let response: NativeAdResponseGeneric<T> = try await LibPubApp.instance().requestAd(nativeAdRequestOptions: adOptions)

            if expectedSuccess {
                XCTAssertNotNil(response.payload, "Payload should not be null")
                XCTAssertNotNil(response.nativeCustomFormatAd, "NativeCustomFormatAd should not be null")
                if !withPrebid {
                    XCTAssertNil(response.prebidNativeAd, "PrebidNativeAd should be null when Prebid is not configured")
                }

                if let pauseAdPayload = response.payload as? PauseAdPayload {
                    self.validatePauseAdPayload(pauseAdPayload, for: adType)
                } else if let bingeAdPayload = response.payload as? BingeAdPayload {
                    self.validateBingeAdPayload(bingeAdPayload)
                } else {
                    XCTFail("Unexpected payload type: \(type(of: response.payload))")
                }

                XCTAssertNotNil(response.interaction, "Interaction should not be null")

                response.interaction.recordImpression()
                response.interaction.performClick(assetName: "abc")
                response.interaction.startViewability(adView: UIView())

            } else {
                XCTFail("Ad request should not succeed")
            }
        } catch {
            if !expectedSuccess {
                XCTAssertNotNil(error, "Error should not be null")
                XCTAssertFalse(error.localizedDescription.isEmpty, "Error description should not be empty")
            } else {
                XCTFail("Ad request should not fail: \(error.localizedDescription)")
            }
        }
    }

    private func validatePauseAdPayload(_ payload: PauseAdPayload, for adType: AdType) {
        XCTAssertNotNil(payload.imageUrl, "imageUrl should be present in PauseAdPayload")
    }

    private func validateBingeAdPayload(_ payload: BingeAdPayload) {
        XCTAssertNotNil(payload.imageUrl, "imageUrl should be present in BingeAdPayload")
        XCTAssertNotNil(payload.logoUrl, "logoUrl should be present in BingeAdPayload")
    }

    func testSingleton() {
        LibPubApp.configure(options: LibPubAppConfig(withPrebid: false))

        let instance1 = LibPubApp.instance()
        let instance2 = LibPubApp.instance()

        XCTAssertTrue(instance1 === instance2, "Instances should be identical")
    }
}

// MARK: - Pause Ad Tests
extension LibPubAppIntegrationTests {
    func testPauseAdRequestWithoutPrebidSuccess() async {
        await performAdRequestTest(
            description: "Pause ad request without Prebid success",
            withPrebid: false,
            adType: .PAUSE_AD,
            adUnit: LibPubAppIntegrationTests.pauseAdUnit,
            customTargeting: LibPubAppIntegrationTests.customTargetingPause,
            expectedSuccess: true,
            payloadType: PauseAdPayload.self
        )
    }

    func testPauseAdRequestWithoutPrebidFailed() async {
        await performAdRequestTest(
            description: "Pause ad request without Prebid failed",
            withPrebid: false,
            adType: .PAUSE_AD,
            adUnit: LibPubAppIntegrationTests.pauseAdUnit,
            customTargeting: [:],
            expectedSuccess: false,
            payloadType: PauseAdPayload.self
        )
    }

    func testPauseAdRequestWithPrebidSuccess() async {
        await performAdRequestTest(
            description: "Pause ad request with Prebid success",
            withPrebid: true,
            adType: .PAUSE_AD,
            adUnit: LibPubAppIntegrationTests.pauseAdUnit,
            prebidOptions: LibPubAppIntegrationTests.prebidOptions,
            customTargeting: LibPubAppIntegrationTests.customTargetingPause,
            expectedSuccess: true,
            payloadType: PauseAdPayload.self
        )
    }

    func testPauseAdRequestWithPrebidFailed() async {
        await performAdRequestTest(
            description: "Pause ad request with Prebid failed",
            withPrebid: true,
            adType: .PAUSE_AD,
            adUnit: LibPubAppIntegrationTests.pauseAdUnit,
            prebidOptions: PrebidOptions(adUnit: "invalid_prebid_ad_unit"),
            customTargeting: [:],
            expectedSuccess: false,
            payloadType: PauseAdPayload.self
        )
    }
}

// MARK: - Binge Ad Tests
extension LibPubAppIntegrationTests {

    func testBingeAdRequestWithoutPrebidSuccess() async {
        await performAdRequestTest(
            description: "Binge ad request without Prebid success",
            withPrebid: false,
            adType: .BINGE_AD,
            adUnit: LibPubAppIntegrationTests.bingeAdUnit,
            customTargeting: LibPubAppIntegrationTests.customTargetingBinge,
            expectedSuccess: true,
            payloadType: BingeAdPayload.self
        )
    }

    func testBingeAdRequestWithoutPrebidFailed() async {
        await performAdRequestTest(
            description: "Binge ad request without Prebid failed",
            withPrebid: false,
            adType: .BINGE_AD,
            adUnit: LibPubAppIntegrationTests.bingeAdUnit,
            customTargeting: [:],
            expectedSuccess: false,
            payloadType: BingeAdPayload.self
        )
    }

    func testBingeAdRequestWithPrebidSuccess() async {
        await performAdRequestTest(
            description: "Binge ad request with Prebid success",
            withPrebid: true,
            adType: .BINGE_AD,
            adUnit: LibPubAppIntegrationTests.bingeAdUnit,
            prebidOptions: LibPubAppIntegrationTests.prebidOptions,
            customTargeting: LibPubAppIntegrationTests.customTargetingBinge,
            expectedSuccess: true,
            payloadType: BingeAdPayload.self
        )
    }

    func testBingeAdRequestWithPrebidFailed() async {
        await performAdRequestTest(
            description: "Binge ad request with Prebid failed",
            withPrebid: true,
            adType: .BINGE_AD,
            adUnit: LibPubAppIntegrationTests.bingeAdUnit,
            prebidOptions: PrebidOptions(adUnit: "invalid_prebid_ad_unit"),
            customTargeting: [:],
            expectedSuccess: false,
            payloadType: BingeAdPayload.self
        )
    }
}
