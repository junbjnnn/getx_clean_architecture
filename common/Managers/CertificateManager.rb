# frozen_string_literal: true

class CertificateManager
  def initialize(fastlane:, keychain_name:)
    @fastlane = fastlane
    @keychain_name = keychain_name
  end

  def import(certificate_path:, certificate_password:)
    certificates = %w[AppleIncRootCertificate AppleComputerRootCertificate AppleRootCA-G2 AppleRootCA-G3 AppleWWDRCA AppleWWDRCAG2 AppleWWDRCAG3 AppleWWDRCAG4 AppleWWDRCAG5 AppleWWDRCAG6 DevAuthCA DeveloperIDCA DeveloperIDG2CA]
    certificates.each do |certificate|
      @fastlane.import_certificate(
        certificate_path: "#{Dir.home}/certs/#{certificate}.cer",
        keychain_path: "#{Dir.home}/Keychains/#{@keychain_name}",
        keychain_password: ""
      )
    end

    @fastlane.import_certificate(
      certificate_path: certificate_path,
      certificate_password: certificate_password,
      keychain_path: "#{Dir.home}/Keychains/#{@keychain_name}",
      keychain_password: ""
    )
  end
end