import SwiftUI
import LibPub

struct ContentView: View {
    @State private var adTypeButton: AdTypeButton = .pause
    @State private var adSource: AdSource = .native
    @State private var adImage: UIImage?
    @State private var iconImage: UIImage?
    @State private var logText: String = ""

    enum AdTypeButton: String, CaseIterable {
        case pause = "Pause Ads"
        case binge = "Binge Ads"
    }

    enum AdSource: String, CaseIterable, Hashable {
        case native = "Formato 'Custom Native'"
    }

    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 15) {
                    Text("App para testar a LibPubApp")
                        .font(.headline)
                        .padding(.top)

                    Picker("Ad Source", selection: .constant(AdSource.native)) {
                        ForEach(AdSource.allCases, id: \.self) { source in
                            Text(source.rawValue)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                    .disabled(true)

                    Picker("Ad Type", selection: $adTypeButton) {
                        ForEach(AdTypeButton.allCases, id: \.self) { type in
                            Text(type.rawValue)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(8)

                    Button(action: {
                        Task {
                            await getAd()
                        }
                    }) {
                        Text("Obter Anúncio")
                            .font(.subheadline)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                    }
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)

                    adImagesView

                    logSection
                }
                .padding()
            }
        }
    }

    // MARK: - Subviews

    var adImagesView: some View {
        VStack {
            if let image = adImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 180)
                    .onTapGesture {
                        print("Imagem do anúncio clicada.")
                    }
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 180)
                    .overlay(Text("Imagem do Anúncio"))
            }

            if adTypeButton == .binge {
                if let icon = iconImage {
                    Image(uiImage: icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                } else {
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 40, height: 40)
                        .overlay(Text("Ícone"))
                }
            }
        }
    }

    var logSection: some View {
        VStack(alignment: .leading) {
            Text("Log:")
                .font(.subheadline)
                .frame(maxWidth: .infinity, alignment: .leading)

            ScrollView {
                Text(logText)
                    .font(.system(size: 11, design: .monospaced))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(height: 130)
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)
        }
    }

    // MARK: - Métodos Auxiliares

    func appendToLog(_ message: String) {
        DispatchQueue.main.async {
            logText += message + "\n"
        }
    }

    func downloadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard !urlString.isEmpty, let url = URL(string: urlString) else {
            print("URL inválida ou vazia: \(urlString)")
            completion(nil)
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Erro ao baixar imagem: \(error.localizedDescription)")
                completion(nil)
                return
            }
            guard let data = data, let image = UIImage(data: data) else {
                print("Dados inválidos para imagem")
                completion(nil)
                return
            }
            completion(image)
        }.resume()
    }

    // MARK: - Ação do Botão "Obter Anúncio"

    func getAd() async {
        LibPubApp.configure(options: LibPubAppConfig(withPrebid: true))
        logText = ""

        let adUnitGAM: String
        let adUnitPrebid: String
        let customTargeting: [String: String]

        switch adTypeButton {
        case .pause:
            appendToLog("Buscando anúncio Pause Ads...")
            adUnitGAM = "/95377733/Testes/Validacao/PauseAds-App"
            adUnitPrebid = "11366-imp-globoplay-ios_pause_ads"
            customTargeting = ["ambient": "app", "tvg_pos": "PAUSEAD"]

        case .binge:
            appendToLog("Buscando anúncio Binge Ads...")
            adUnitGAM = "/95377733/Testes/Validacao/BingeAds-App"
            adUnitPrebid = "11366-imp-globoplay-ios_binge_ads"
            customTargeting = ["ambient": "app", "tvg_pos": "BINGEAD"]
        }

        let prebidOptions = PrebidOptions(adUnit: adUnitPrebid,
                                          containerView: UIView(),
                                          clickableViews: [UIView()]) // TODO

        let adOptions = NativeAdRequestOptions(
            adType: adTypeButton == .pause ? .PAUSE_AD : .BINGE_AD,
            adUnit: adUnitGAM,
            prebidOptions: prebidOptions,
            ppid: "9caf98bb6c2dd8c620b6f093a044269ade5e9786110f2598a54a78b5ec1207a7",
            customTargeting: customTargeting
        )

        do {
            if adTypeButton == .pause {
                let response: NativeAdResponseGeneric<PauseAdPayload> =
                try await LibPubApp.instance().requestAd(nativeAdRequestOptions: adOptions)
                handleSuccess(response)
            } else {
                let response: NativeAdResponseGeneric<BingeAdPayload> =
                try await LibPubApp.instance().requestAd(nativeAdRequestOptions: adOptions)
                handleSuccess(response)
            }
        } catch {
            handleFailure(error)
        }
    }

    // MARK: - Handlers

    func handleSuccess<T>(_ response: NativeAdResponseGeneric<T>) {
        print("Anúncio carregado: \(response)")

        if response.prebidNativeAd != nil {
            appendToLog("Recebeu anúncio do Prebid")
        } else {
            appendToLog("Recebeu anúncio do GAM")
            response.interaction.recordImpression()
            response.interaction.performClick(assetName: "imagem")
        }

        if let pauseAdPayload = response.payload as? PauseAdPayload {
            downloadImage(from: pauseAdPayload.imageUrl) { image in
                if let image = image {
                    DispatchQueue.main.async {
                        self.adImage = image
                    }
                }
            }
        } else if let bingeAdPayload = response.payload as? BingeAdPayload {
            downloadImage(from: bingeAdPayload.imageUrl) { image in
                if let image = image {
                    DispatchQueue.main.async {
                        self.adImage = image
                    }
                }
            }
            downloadImage(from: bingeAdPayload.logoUrl) { image in
                if let image = image {
                    DispatchQueue.main.async {
                        self.iconImage = image
                    }
                }
            }
        }
    }

    func handleFailure(_ error: Error) {
        print("Falha ao carregar anúncio: \(error.localizedDescription)")
        appendToLog("Erro: \(error.localizedDescription)")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

#Preview {
    ContentView()
}
