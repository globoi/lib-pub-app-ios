import XCTest
@testable import LibPub

class PrebidTemplateIdRepositoryTests: XCTestCase {

    func testPauseAdAppDevice() {
        let templateId = PrebidTemplateIdRepository.getTemplateIdByAdType(adType: .PAUSE_AD, device: .APP)
        XCTAssertEqual(templateId, "12365901")
    }

    func testBingeAdAppDevice() {
        let templateId = PrebidTemplateIdRepository.getTemplateIdByAdType(adType: .BINGE_AD, device: .APP)
        XCTAssertEqual(templateId, "12365901")
    }

    func testAllAdTypesReturnSameIdForAppDevice() {
        let pauseAdId = PrebidTemplateIdRepository.getTemplateIdByAdType(adType: .PAUSE_AD, device: .APP)
        let bingeAdId = PrebidTemplateIdRepository.getTemplateIdByAdType(adType: .BINGE_AD, device: .APP)
        XCTAssertEqual(pauseAdId, bingeAdId)
    }

    func testAllAdTypesAreCovered() {
        let allAdTypes: [AdType] = [.PAUSE_AD, .BINGE_AD]
        for adType in allAdTypes {
            let templateId = PrebidTemplateIdRepository.getTemplateIdByAdType(adType: adType, device: .APP)
            XCTAssertFalse(templateId.isEmpty)
        }
    }
}
