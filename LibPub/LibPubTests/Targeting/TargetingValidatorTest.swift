import XCTest
@testable import LibPub

class TargetingRuleTests: XCTestCase {
    func testOptionalTargetingWithEmptyValidValues() {
        let targetingRule = TargetingRule(
            isOptional: true
        )

        XCTAssertTrue(targetingRule.validate(value: nil))
    }

    func testOptionalTargetingWithNonEmptyValidValues() {
        let targetingRule = TargetingRule(
            isOptional: true,
            validValues: ["lala"]
        )

        XCTAssertTrue(targetingRule.validate(value: nil))
        XCTAssertTrue(targetingRule.validate(value: "lala"))
        XCTAssertFalse(targetingRule.validate(value: "popo"))
    }

    func testMandatoryTargetingWithEmptyValidValues() {
        let targetingRule = TargetingRule(
            isOptional: false
        )

        XCTAssertFalse(targetingRule.validate(value: nil))
        XCTAssertTrue(targetingRule.validate(value: "lala"))
    }

    func testMandatoryTargetingWithNonEmptyValidValues() {
        let targetingRule = TargetingRule(
            isOptional: false,
            validValues: ["lala"]
        )

        XCTAssertFalse(targetingRule.validate(value: nil))
        XCTAssertTrue(targetingRule.validate(value: "lala"))
        XCTAssertFalse(targetingRule.validate(value: "popo"))
    }
}

class TargetingValidatorTests: XCTestCase {

    func testValidTargeting() {
        let validTargeting: [String: String] = [
            "glb_id": "id1",
            "glb_tipo": "assinante",
            "glb_assinante": "sim",
            "available_for": "SUBSCRIBER",
            "op": "operacao1",
            "ambient": "web",
            "gp_platform": "app",
            "tvg_pos": "HOME1",
            "tvg_cma": "cma1",
            "tvg_pgStr": "pagina1",
            "tvg_pgTipo": "Home",
            "tvg_pgName": "nome1",
            "tipo_pagina": "home",
            "gp_gender": "masculino",
            "device_type": "mobile",
            "pa": "pa1",
            "v_id": "video1",
            "video_kind": "episode",
            "video_category": "news",
            "video_subscription": "true",
            "video_program": "programa1",
            "program_genre": "variedades",
            "permutive": "permutive1",
            "permutive-id": "permutive-id1"
        ]

        XCTAssertTrue(TargetingValidator.validate(targeting: validTargeting))
    }

    func testInvalidTargeting() {
        let invalidTargeting: [String: String] = [
            "glb_id": "id1",
            "glb_tipo": "invalid_tipo",
            "ambient": "invalid_ambient",
            "tvg_pos": "INVALID_POS",
            "tipo_pagina": "invalid_pagina"
        ]

        XCTAssertFalse(TargetingValidator.validate(targeting: invalidTargeting))
    }

    func testMissingRequiredFields() {
        let incompleteTargeting: [String: String] = [
            "ambient": "web",
            "available_for": "SUBSCRIBER"
        ]

        XCTAssertFalse(TargetingValidator.validate(targeting: incompleteTargeting))
    }

    func testEmptyTargeting() {
        let emptyTargeting: [String: String] = [:]

        XCTAssertFalse(TargetingValidator.validate(targeting: emptyTargeting))
    }

    func testPartiallyValidTargeting() {
        let partiallyValidTargeting: [String: String] = [
            "ambient": "web",
            "available_for": "SUBSCRIBER",
            "device_type": "mobile",
            "gp_gender": "invalid_gender",
            "glb_tipo": "assinante",
            "platform": "app",
            "tipo_pagina": "home",
            "tvg_pos": "INVALID_POS",
            "tvg_pgTipo": "Home",
            "video_category": "news",
            "video_kind": "episode",
            "video_subscription": "true"
        ]

        XCTAssertFalse(TargetingValidator.validate(targeting: partiallyValidTargeting))
    }
}
