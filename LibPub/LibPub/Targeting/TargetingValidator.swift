struct TargetingRule {
    let isOptional: Bool
    let validValues: Set<String>?

    init(isOptional: Bool, validValues: Set<String>? = nil) {
        self.isOptional = isOptional
        self.validValues = validValues
    }

    func validate(value: String?) -> Bool {
        if value == nil {
            return self.isOptional
        }

        if let valid = self.validValues {
            if let v = value {
                return valid.contains(v)
            }

            return false
        }

        return true
    }
}

struct TargetingValidator {
    static let TargetingRules: [String: TargetingRule] = [
        // GLB TARGETING
        "available_for": TargetingRule(
            isOptional: true,
            validValues: [
                "ANONYMOUS",
                "LOGGED_IN",
                "SUBSCRIBER"
            ]
        ),
        "glb_assinante": TargetingRule(
            isOptional: true
        ),
        "glb_id": TargetingRule(
            isOptional: false
        ),
        "glb_tipo": TargetingRule(
            isOptional: false,
            validValues: [
                "anonimo",
                "nao-assinante",
                "assinante"
            ]
        ),
        "op": TargetingRule(
            isOptional: true
        ),

        // CONTEXT TARGETING
        "ambient": TargetingRule(
            isOptional: false,
            validValues: [
                "amp",
                "app",
                "tv",
                "web"
            ]
        ),
        "gp_platform": TargetingRule(
            isOptional: false,
            validValues: [
                "app",
                "roku",
                "tv",
                "web"
            ]
        ),
        "tipo_pagina": TargetingRule(
            isOptional: false,
            validValues: [
                "cartola aberto",
                "cartola fechado",
                "cobertura-ao-vivo",
                "gcom",
                "globoplay",
                "home",
                "jogos",
                "multi-content",
                "placar-ge",
                "playlist",
                "tabela",
                "tempo-real",
                "topic",
                "video",
                "votacao"
            ]
        ),
        "tvg_cma": TargetingRule(
            isOptional: true
        ),
        "tvg_pgName": TargetingRule(
            isOptional: true
        ),
        "tvg_pgStr": TargetingRule(
            isOptional: true
        ),
        "tvg_pgTipo": TargetingRule(
            isOptional: true,
            validValues: [
                "arena",
                "catalogo",
                "cobertura-ao-vivo",
                "episodio",
                "Galeria",
                "GloboPlay",
                "Home",
                "Materia",
                "Plantao",
                "playlist",
                "votacao"
            ]
        ),
        "tvg_pos": TargetingRule(
            isOptional: false,
            validValues: [
                "BINGEAD",
                "EXTRA",
                "EXTRA_M",
                "FEED",
                "FEED_ESPECIAL",
                "FEED_ESPECIAL_M",
                "FEED_M",
                "FRAMEAD",
                "HOME_FEED",
                "HOME_FIM",
                "HOME1",
                "HOME1_M",
                "HOME2",
                "HOME2_M",
                "HOME3",
                "HOME3_M",
                "HOME4",
                "HOME4_M",
                "HOME5",
                "HOME5_M",
                "HOME6",
                "HOME6_M",
                "HOME7_M",
                "HOME8_M",
                "HOME9_M",
                "HOME10_M",
                "INSERT",
                "MATERIA",
                "MATERIA_M",
                "MATERIA_TOPO",
                "MATERIA_TOPO_M",
                "MATERIA1",
                "MATERIA1_M",
                "MATERIA2",
                "MATERIA2_M",
                "PAUSEAD",
                "SHORTZ",
                "VOTACAO",
                "WEBSTORIES"
            ]
        ),

        // DEVICE TYPE
        "device_type": TargetingRule(
            isOptional: true,
            validValues: [
                "android",
                "android_tv",
                "chromecast",
                "desktop",
                "fire_tv",
                "html",
                "ios",
                "mobile",
                "nativa",
                "roku",
                "smart_app",
                "tablet",
                "tvos"
            ]
        ),

        // MEDIA TARGETING
        "pa": TargetingRule(
            isOptional: true
        ),
        "program_genre": TargetingRule(
            isOptional: true,
            validValues: [
                "acao",
                "biografia",
                "comedia",
                "comedia romantica",
                "documentario",
                "drama",
                "historia",
                "historia e politica",
                "musica",
                "personalidade",
                "policial",
                "politica",
                "romance",
                "saude",
                "variedades"
            ]
        ),
        "video_category": TargetingRule(
            isOptional: true,
            validValues: [
                "adulto",
                "badd blood",
                "cartoons",
                "documentaries",
                "entretenimento",
                "esportes",
                "long",
                "made_for_tv",
                "miniseries",
                "news",
                "none",
                "notícias",
                "realities",
                "sem categoria",
                "series",
                "short",
                "shows",
                "soap_opera",
                "sports",
                "talk_shows",
                "varieties"
            ]
        ),
        "v_id": TargetingRule(
            isOptional: true
        ),
        "video_kind": TargetingRule(
            isOptional: true,
            validValues: [
                "acompanhamentos",
                "ad",
                "collaborative",
                "episode",
                "excerpt",
                "extra",
                "gallery",
                "live",
                "segment",
                "teaser",
                "trailer"
            ]
        ),
        "video_program": TargetingRule(
            isOptional: true
        ),
        "video_subscription": TargetingRule(
            isOptional: true,
            validValues: [
                "false",
                "true"
            ]
        ),

        // USER TARGETING
        "gp_gender": TargetingRule(
            isOptional: true,
            validValues: [
                "feminino",
                "masculino",
                "N/A",
                "outro"
            ]
        ),

        // PERMUTIVE TARGETING
        "permutive-id": TargetingRule(
            isOptional: true
        ),
        "segments": TargetingRule(
            isOptional: true
        ),
    ]

    static func validate(targeting: [String: String]) -> Bool {
        var isValid = true

        for (key, targetingRule) in self.TargetingRules {
            let value = targeting[key]

            if !targetingRule.validate(value: value) {
                isValid = false

                log("Invalid value for targeting key '\(key)'.")

                if targetingRule.isOptional {
                    log("The targeting key '\(key)' is mandatory.")
                }

                if let v = targetingRule.validValues {
                    log("Expected one of: '\(v.joined(separator: ", "))'. Found: '\(String(describing: value))'.")
                }
            }
        }

        return isValid
    }
}
