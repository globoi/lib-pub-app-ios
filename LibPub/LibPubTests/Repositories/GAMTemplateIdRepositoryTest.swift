import XCTest
@testable import LibPub

class GAMTemplateIdRepositoryTests: XCTestCase {

    func testPauseAdAppDevice() {
        let templateId = GAMTemplateIdRepository.getTemplateIdByAdType(adType: .PAUSE_AD, device: .APP)
        XCTAssertEqual(templateId, "12198352")
    }

    func testBingeAdAppDevice() {
        let templateId = GAMTemplateIdRepository.getTemplateIdByAdType(adType: .BINGE_AD, device: .APP)
        XCTAssertEqual(templateId, "12295596")
    }

    func testDifferentAdTypesReturnDifferentIds() {
        let pauseAdId = GAMTemplateIdRepository.getTemplateIdByAdType(adType: .PAUSE_AD, device: .APP)
        let bingeAdId = GAMTemplateIdRepository.getTemplateIdByAdType(adType: .BINGE_AD, device: .APP)
        XCTAssertNotEqual(pauseAdId, bingeAdId)
    }

    func testAllAdTypesAreCovered() {
        let allAdTypes: [AdType] = [.PAUSE_AD, .BINGE_AD]
        for adType in allAdTypes {
            let templateId = GAMTemplateIdRepository.getTemplateIdByAdType(adType: adType, device: .APP)
            XCTAssertFalse(templateId.isEmpty)
        }
    }

    func testAllDevicesAreCovered() {
        let allDevices: [Device] = [.APP]
        let adType: AdType = .PAUSE_AD

        for device in allDevices {
            let templateId = GAMTemplateIdRepository.getTemplateIdByAdType(adType: adType, device: device)
            XCTAssertFalse(templateId.isEmpty)
        }
    }
}
