# frozen_string_literal: true

class ProvisioningManager
  def initialize(fastlane:)
    @fastlane = fastlane
  end

  def get_and_install(is_adhoc:, team_id:, provisioning_name:, app_identifier:, filename:, output_path:, key_id:, issuer_id:, key_content:)
    @fastlane.get_provisioning_profile(
      adhoc: is_adhoc,
      api_key: set_connect_api_key(key_id, issuer_id, key_content),
      skip_install: true,
      team_id: team_id,
      provisioning_name: provisioning_name,
      app_identifier: app_identifier,
      filename: "#{filename}.mobileprovision",
      output_path: output_path,
      readonly: true
    )

    @fastlane.install_provisioning_profile(
      path: "#{output_path}/#{filename}.mobileprovision"
    )
  end

  ## set App Store connect API key ##
  def set_connect_api_key(key_id, issuer_id, key_content)
    @fastlane.app_store_connect_api_key(
      key_id: key_id,
      issuer_id: issuer_id,
      key_content: key_content || '',
      is_key_content_base64: true,
      duration: 1200,
      in_house: false
    )
  end
end