Pod::Spec.new do |s|
    s.name = 'LibPub'
    s.version = '0.0.1'
    s.summary = 'Framework for ad delivery.'
    s.description = 'Ad delivery via Prebid or GAM.'
    s.homepage = 'https://gitlab.globoi.com/adtech/delivery-e-performance-digital/gama-core/ads-lib/lib-pub-app-ios'
    s.license = {
      :type => 'MIT',
      :file => 'LICENSE'
    }
    s.source = {
      :git => 'https://gitlab.globoi.com/adtech/delivery-e-performance-digital/gama-core/ads-lib/lib-pub-app-ios.git',
      :tag => s.version.to_s
    }
    s.author = {
      'Globo Comunicação e Participações S.A' => 'https://www.globo.com/'
    }
    s.swift_version = '5.9'
    s.ios.deployment_target = '14.0'
    s.framework = 'Foundation'
    s.static_framework = true
    s.source_files = 'LibPub/LibPub/**/*.{h,m,swift}'
    s.dependency 'Google-Mobile-Ads-SDK', '11.13.0'
    s.dependency 'PrebidMobile', '2.4.0'
  end
