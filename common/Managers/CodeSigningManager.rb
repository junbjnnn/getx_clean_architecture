# frozen_string_literal: true

class CodeSigningManager
  def initialize(fastlane:)
    @fastlane = fastlane
  end

  def update_code_signing_settings(path:, team_id:, profile_name:, bundle_identifier:, targets:, build_configurations:, code_sign_identity:)
    @fastlane.update_code_signing_settings(
      use_automatic_signing: false,
      path: path,
      team_id: team_id,
      profile_name: profile_name,
      bundle_identifier: bundle_identifier,
      targets: targets,
      build_configurations: build_configurations,
      code_sign_identity: code_sign_identity,
      verbose: true
    )
  end
end